import 'package:fpdart/fpdart.dart';

extension EitherExt on Either {
  get asLeft => (this as Left).value;
  get asRight => (this as Right).value;
}
