import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_demo/domain/model/booking_info.dart';
import 'package:hotel_demo/domain/model/tourist.dart';
import 'package:hotel_demo/domain/state/booking_screen_state.dart';
import 'package:hotel_demo/domain/numbers_to_title.dart';
import 'package:hotel_demo/domain/phone_number_formatter.dart';
import 'package:hotel_demo/presentation/rating_widget.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  final _phoneNumberFormatter = PhoneNumberFormatter();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _isFieldError = <String, bool>{};
  bool _isEmailError = false;
  bool _isPhoneError = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode.addListener(() {
      if (_phoneNumberController.text.isEmpty) {
        _phoneNumberController.text = "+7 (***) ***-**-**";
        _phoneNumberController.selection =
            const TextSelection.collapsed(offset: 4);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingFuture = ref.watch(bookingProvider);
    final tourists = ref.watch(touristListProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 249),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Бронирование"),
      ),
      body: bookingFuture.when(
        data: (bookingInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _getHotelMainInfoCard(bookingInfo),
                _getHotelInfoCard(bookingInfo),
                _getBuyerInfoCard(),
                ...tourists.map((t) => _getTouristInfoCard(t)),
                _getAddTouristCard(),
                _getPaymentDetailsCard(bookingInfo),
              ],
            ),
          );
        },
        error: (obj, trace) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Произошла ошибка при загрузке"),
              ],
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: bookingFuture.when(
          data: (bookingInfo) {
            final finalPrice = bookingInfo.price +
                bookingInfo.fuelCharge +
                bookingInfo.serviceCharge;
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      bool isValid = true;
                      _formKeys.forEach((element) {
                        isValid &= element.currentState!.validate();
                      });
                      if (isValid) {
                        context.push('/payment');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Оплатить $finalPrice ₽",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          error: (obj, trace) => null,
          loading: () => null),
    );
  }

  Widget _getHotelMainInfoCard(BookingInfo bookingInfo) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingWidget(
                  rating: bookingInfo.rating,
                  ratingName: bookingInfo.ratingName),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(bookingInfo.hotelName,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500)),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  bookingInfo.hotelAddress,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 13, 114, 255)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHotelInfoCard(BookingInfo bookingInfo) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Вылет из",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        bookingInfo.departure,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Страна, город",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        bookingInfo.arrivalCountry,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Даты",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${bookingInfo.tourStartString} - ${bookingInfo.tourEndString}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Кол-во ночей",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${bookingInfo.nights} ночей",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Отель",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        bookingInfo.hotelName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Номер",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        bookingInfo.room,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Питание",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        bookingInfo.nutrition,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _getBuyerInfoCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKeys[0],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Информация о покупателе",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isPhoneError
                            ? const Color.fromARGB(38, 235, 87, 87)
                            : const Color.fromARGB(255, 246, 246, 249),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2),
                        child: TextFormField(
                          validator: validatePhone,
                          enableInteractiveSelection: false,
                          controller: _phoneNumberController,
                          focusNode: _phoneNumberFocusNode,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                "Номер телефона",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 169, 171, 183)),
                              )),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            _phoneNumberFormatter,
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isEmailError
                          ? const Color.fromARGB(38, 235, 87, 87)
                          : const Color.fromARGB(255, 246, 246, 249),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2),
                      child: TextFormField(
                        controller: _emailController,
                        validator: validateEmail,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: Text(
                              "Почта",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 169, 171, 183)),
                            )),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 130, 135, 150),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTouristInfoCard(Tourist tourist) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: ExpansionTile(
            maintainState: true,
            trailing: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 241, 255),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                tourist.expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
            ),
            shape: const Border.fromBorderSide(BorderSide.none),
            initiallyExpanded: true,
            onExpansionChanged: (bool state) {
              ref.read(touristListProvider.notifier).toggle(tourist);
            },
            tilePadding: const EdgeInsets.only(right: 8),
            title: Text(
              "${touristLUT[tourist.id + 1]} турист",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            children: [
              Form(
                key: _formKeys[tourist.id + 1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getInputField("${tourist.id}-0}", "Имя",
                        TextInputType.text, validate),
                    _getInputField("${tourist.id}-1}", "Фамилия",
                        TextInputType.text, validate),
                    _getInputField("${tourist.id}-2}", "Дата рождения",
                        TextInputType.datetime, validate),
                    _getInputField("${tourist.id}-3}", "Гражданство",
                        TextInputType.text, validate),
                    _getInputField("${tourist.id}-4}", "Номер загранпаспорта",
                        TextInputType.number, validate),
                    _getInputField(
                        "${tourist.id}-5}",
                        "Срок действия загранпаспорта",
                        TextInputType.datetime,
                        validate),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAddTouristCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Добавить туриста",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  _formKeys.add(GlobalKey<FormState>());
                  ref.read(touristListProvider.notifier).add();
                },
                icon: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPaymentDetailsCard(BookingInfo bookingInfo) {
    return SizedBox(
      width: double.infinity,
      child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              children: [
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Тур",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 130, 135, 150)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${bookingInfo.price} ₽",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Топливный сбор",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 130, 135, 150)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${bookingInfo.fuelCharge} ₽",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Сервисный сбор",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 130, 135, 150)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${bookingInfo.serviceCharge} ₽",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "К оплате",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 130, 135, 150)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${bookingInfo.price + bookingInfo.fuelCharge + bookingInfo.serviceCharge} ₽",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 114, 255),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ])
              ],
            ),
          )),
    );
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Пожалуйста заполните это поле";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _isEmailError = true;
      });
      return "Пожалуйста заполните это поле";
    }
    final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!re.hasMatch(value)) {
      setState(() {
        _isEmailError = true;
      });
      return "Неверный формат почты";
    }
    setState(() {
      _isEmailError = false;
    });
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _isPhoneError = true;
      });
      return "Пожалуйста заполните это поле";
    }
    final re = RegExp(r'^\+7\s\(\d{3}\)\s\d{3}-\d{2}-\d{2}$');
    if (!re.hasMatch(value)) {
      setState(() {
        _isPhoneError = true;
      });
      return "Неверный формат номера телефона";
    }
    setState(() {
      _isPhoneError = false;
    });
    return null;
  }

  Widget _getInputField(String id, String title, TextInputType textInputType,
      String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: _isFieldError[id] ?? false
              ? const Color.fromARGB(38, 235, 87, 87)
              : const Color.fromARGB(255, 246, 246, 249),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: TextFormField(
            validator: (String? value) {
              final res = validator(value);
              if (res != null) {
                setState(() {
                  _isFieldError[id] = true;
                });
              } else {
                setState(() {
                  _isFieldError[id] = false;
                });
              }
              return res;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                label: Text(
                  title,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 169, 171, 183)),
                )),
            keyboardType: textInputType,
          ),
        ),
      ),
    );
  }
}
