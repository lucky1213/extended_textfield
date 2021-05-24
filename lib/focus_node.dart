part of flutter_extended_text_field;

class SelectableFocusNode extends FocusNode {
  SelectableFocusNode([this.allowFocus = true]) : super();
  final bool allowFocus;
}

class ExtendedFocusNode extends FocusNode {
  ExtendedFocusNode([this.keyboardToken = true]) : super();

  bool keyboardToken;

  // @override
  // bool get hasFocus => _hasFocus;

  @override
  bool consumeKeyboardToken() {
    return keyboardToken;
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  void showKeyboard() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.show');
  }

  @override
  void unfocus({
    UnfocusDisposition disposition = UnfocusDisposition.scope,
    bool showCursor = false,
  }) {
    keyboardToken = false;
    if (showCursor) {
      hideKeyboard();
    } else {
      super.unfocus(disposition: disposition);
    }
  }

  @override
  void requestFocus([FocusNode? node, bool keyboard = true]) {
    keyboardToken = keyboard;
    if (keyboardToken) {
      showKeyboard();
    } else {
      hideKeyboard();
    }
    super.requestFocus();
  }
}
