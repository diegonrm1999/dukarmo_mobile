import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/dto/order_dto.dart';
import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/domain/order_treatment.dart';
import 'package:dukarmo_app/domain/treatment.dart';
import 'package:dukarmo_app/domain/treatment_entry.dart';
import 'package:dukarmo_app/domain/user.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/client_service.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/services/treatment_service.dart';
import 'package:dukarmo_app/services/user_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';

class OrderController extends ChangeNotifier {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Map<String, Treatment> treatmentItems = {};
  Map<String, User> stylistItems = {};
  Map<String, User> cashierItems = {};
  User? selectedStylist;
  User? selectedCashier;
  GoRouterState? state;
  Order? currentOrder;
  final ValueNotifier<bool> isDniLoading = ValueNotifier(false);
  final selectedTreatments = ValueNotifier<List<TreatmentEntry>>([]);
  final ValueNotifier<bool> isSubmitLoading = ValueNotifier(false);
  final ValueNotifier<StatusPage> statusPage = ValueNotifier(
    StatusPage.loading,
  );
  bool _isDisposed = false;
  final _treatmentService = getSingleton<TreatmentService>();
  final _userService = getSingleton<UserService>();
  final _orderService = getSingleton<OrderService>();
  final _clientService = getSingleton<ClientService>();
  final _snackbar = getSingleton<Snackbar>();
  final _navigationService = getSingleton<NavigationService>();

  List<User> get stylistList => stylistItems.values.toList();
  List<User> get cashierList => cashierItems.values.toList();
  List<Treatment> get treatmentList => treatmentItems.values.toList();

  OrderController({this.state}) {
    _onInit();
  }

  String get buttonMessage {
    if (state == null) {
      return "Crear Orden";
    } else {
      return "Actualizar Orden";
    }
  }

  String get titleMessage {
    if (state == null) {
      return "Nueva Orden";
    } else {
      return "Actualizar Orden";
    }
  }

  String userName(User selectedUser) {
    return '${selectedUser.firstName} ${selectedUser.lastName}';
  }

  Future<void> _onInit() async {
    try {
      await getTreatments();
      await getCashiers();
      await getStylists();
      await getCurrentOrder();
      statusPage.value = StatusPage.success;
    } catch (e) {
      statusPage.value = StatusPage.error;
      _snackbar.show("Error al cargar los datos");
    } finally {
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Future<void> getCurrentOrder() async {
    if (state == null) return;
    final orderId = state!.extra as String;
    final order = await _orderService.getSelectedOrder(orderId);
    selectedStylist = stylistItems[order.stylist.id];
    selectedCashier = cashierItems[order.cashier.id];
    dniController.text = order.client.dni;
    customerNameController.text = order.client.name;
    emailController.text = order.client.email ?? '';
    phoneController.text = order.client.phone ?? '';
    setSelectedTreatments(order.treatments);
    currentOrder = order;
  }

  void setSelectedTreatments(List<OrderTreatment> treatmentList) {
    selectedTreatments.value = treatmentList
        .map((e) => TreatmentEntry(treatmentId: e.treatment.id, price: e.price))
        .toList();
  }

  Future<void> getTreatments() async {
    final services = await _treatmentService.getTreatments();
    treatmentItems = {for (var item in services) item.id: item};
  }

  Future<void> getCashiers() async {
    final cashiers = await _userService.getAllCashiers();
    cashierItems = {for (var item in cashiers) item.id: item};
  }

  Future<void> getStylists() async {
    final stylists = await _userService.getAllStylists();
    stylistItems = {for (var item in stylists) item.id: item};
  }

  void onCashierSelected(String? key) {
    if (key == null) return;
    selectedCashier = cashierItems[key];
    if (_isDisposed) return;
    notifyListeners();
  }

  void onStylistSelected(User stylist) {
    selectedStylist = stylist;
    if (_isDisposed) return;
    notifyListeners();
  }

  bool validateSelectedTreatments() {
    if (selectedTreatments.value.isEmpty) return false;
    for (final entry in selectedTreatments.value) {
      if (entry.treatmentId == null || entry.treatmentId!.isEmpty) return false;
      if (entry.price == null || entry.price!.isNaN || entry.price! <= 0) {
        return false;
      }
    }
    return true;
  }

  bool validateFields() {
    if (selectedStylist == null ||
        selectedCashier == null ||
        !validateSelectedTreatments() ||
        customerNameController.text.isEmpty ||
        (emailController.text.isEmpty && phoneController.text.isEmpty)) {
      _snackbar.show("Por favor, complete todos los campos correctamente");
      return true;
    }
    if (dniController.text.isNotEmpty &&
        !RegExp(r'^\d{8}$').hasMatch(dniController.text)) {
      _snackbar.show("Por favor, ingrese un DNI válido");
      return true;
    }
    return false;
  }

  Future<void> onDniSearch() async {
    isDniLoading.value = true;
    try {
      final dni = dniController.text.trim();
      if (dni.isEmpty) return;
      final client = await _clientService.getClientByDni(dni);
      customerNameController.text = client.name;
      dniController.text = client.dni;
      emailController.text = client.email ?? '';
      phoneController.text = client.phone ?? '';
    } catch (e) {
      _snackbar.show("No se encontró el cliente con el DNI proporcionado");
    } finally {
      isDniLoading.value = false;
    }
  }

  Future<void> onSubmitOrder() async {
    isSubmitLoading.value = true;
    if (validateFields()) {
      isSubmitLoading.value = false;
      return;
    }
    final order = orderDto;
    try {
      if (state == null) {
        await _orderService.createOrder(order);
        isSubmitLoading.value = false;
        _navigationService.offAllNamed(AppRoutes.home);
      } else {
        await _orderService.updateOrder(order, state!.extra as String);
        isSubmitLoading.value = false;
        _snackbar.show("Orden actualizada correctamente");
      }
    } catch (e) {
      _snackbar.show("Error al procesar la orden");
      isSubmitLoading.value = false;
    }
  }

  void onAddEntry() {
    selectedTreatments.value = [...selectedTreatments.value, TreatmentEntry()];
  }

  void onRemoveEntry(int index) {
    final entries = selectedTreatments.value;
    if (entries.length > 1) {
      entries.removeAt(index);
      selectedTreatments.value = [...entries];
    } else {
      _snackbar.show("Debe haber al menos un servicio seleccionado");
    }
  }

  OrderDto get orderDto {
    return OrderDto(
      stylistId: selectedStylist?.id ?? '',
      cashierId: selectedCashier?.id ?? '',
      clientDni: dniController.text,
      clientName: customerNameController.text,
      clientEmail: emailController.text,
      clientPhone: phoneController.text,
      treatments: selectedTreatments.value,
    );
  }

  void onBackPressed() {
    _navigationService.offAllNamed(AppRoutes.home);
  }

  @override
  void dispose() {
    customerNameController.dispose();
    dniController.dispose();
    emailController.dispose();
    phoneController.dispose();
    isDniLoading.dispose();
    isSubmitLoading.dispose();
    selectedTreatments.dispose();
    statusPage.dispose();
    _isDisposed = true;
    super.dispose();
  }
}
