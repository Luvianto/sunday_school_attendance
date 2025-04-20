import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final void Function()? backInvoked;
  final Widget? floatingActionButton;
  final List<PopupMenuItem>? menuItems;

  const PageLayout({
    super.key,
    required this.body,
    this.title,
    this.backInvoked,
    this.floatingActionButton,
    this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Dengan suatu alasan butuh kedua atribut harus ada
        // (backgroundColor dan surfaceTintColor)
        // Supaya AppBar tidak berubah warna saat halaman discroll
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        shadowColor: Theme.of(context).colorScheme.outlineVariant,
        automaticallyImplyLeading: false,
        title: title != null
            ? Text(
                title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        // Untuk sekarang leading yang paling umum cuman BackButton
        leading: backInvoked != null
            ? IconButton(
                onPressed: backInvoked,
                icon: Icon(Icons.arrow_back),
              )
            : null,
        // Untuk sekarang actions akan dimasukkan ke dalam PopUpMenu
        actions: menuItems != null
            ? [
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => menuItems!,
                )
              ]
            : null,
      ),
      body: backInvoked != null
          ? PopScope(
              // Override Android Back Button
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  backInvoked;
                }
              },
              child: body,
            )
          : body,
      floatingActionButton: floatingActionButton,
    );
  }
}
