String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  // sebelum @
  // - Bisa berisi huruf (a-z, A-Z), angka (0-9), titik (.), underscore (_), persen (%), plus (+), dan minus (-)
  // - Harus ada minimal satu karakter
  // setelah @
  // - Bisa berisi huruf (a-z, A-Z), angka (0-9), titik (.), dan minus (-)
  // - Harus ada minimal satu karakter
  // Wajib ada satu titik (.) setelahnya
  // Bagian terakhir harus terdiri dari huruf (a-z, A-Z), minimal 2 karakter
  // '$' Akhir dari String
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Format email tidak valid';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Kata sandi tidak boleh kosong';
  }
  if (value.length < 8) {
    return 'Kata sandi minimal 8 karakter';
  }
  return null;
}

String? emptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Bagian in harus diisi!';
  }
  return null;
}
