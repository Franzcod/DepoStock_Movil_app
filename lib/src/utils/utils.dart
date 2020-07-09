



//pra validar si es un numero o no
bool isNumeric( String s ) {

  if ( s.isEmpty ) return false;

  final n = num.tryParse(s);

  return ( n == null ) ? false : true;

}