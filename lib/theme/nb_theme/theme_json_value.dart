import 'package:ui_kit/theme/nb_theme/nb_theme.dart';

///Pattern: Chain of Responsibility
abstract class JsonValue {
  JsonValue? next;

  JsonValue setNext(JsonValue nextValue) {
    var nextJsonValue = next;
    if (nextJsonValue != null) {
      while (nextJsonValue!.next != null) {
        nextJsonValue = nextJsonValue.next;
      }
      nextJsonValue.next = nextValue;
    } else {
      next = nextValue;
    }
    return this;
  }

  dynamic getValue(ThemeValueRequest themeValueRequest, NbTheme theme);
}

class AppJsonValue extends JsonValue {
  @override
  getValue(ThemeValueRequest themeValueRequest, NbTheme theme) {
    return theme.getAttr(themeValueRequest.valueKey);
  }
}

class ScreenJsonValue extends JsonValue {
  @override
  getValue(ThemeValueRequest themeValueRequest, NbTheme theme) {
    final overridesScreen = theme.overridesScreen;
    if (overridesScreen == null) {
      return next!.getValue(themeValueRequest, theme);
    }
    final screen = overridesScreen[themeValueRequest.screenKey];
    if (screen == null || !screen.containsKey(themeValueRequest.valueKey)) {
      return next!.getValue(themeValueRequest, theme);
    }
    return theme.getOverriddenAttr(screen, themeValueRequest.valueKey);
  }
}

class CardJsonValue extends JsonValue {
  @override
  dynamic getValue(ThemeValueRequest themeValueRequest, NbTheme theme) {
    final overridesCard = theme.overridesCard;
    if (overridesCard == null) {
      return next!.getValue(themeValueRequest, theme);
    }
    final card = overridesCard[themeValueRequest.cardKey];
    if (card == null || !card.containsKey(themeValueRequest.valueKey)) {
      return next!.getValue(themeValueRequest, theme);
    }

    return theme.getOverriddenAttr(card, themeValueRequest.valueKey);
  }
}
