FUNCTION pdsf, $
   x, $
   params, $
   psf1, $
   psf2, $
   psf3, $
   DEBUG = debug, $
   EXCPT_COND = excpt_cond

   ;Sec-Doc
   ;  PURPOSE: This IDL function computes the value of the Parametric
   ;  Double Sine Function (PDSF) at argument x, given the array of 7
   ;  parameters params, as well as its 2 components.
   ;
   ;  ALGORITHM: Given the 7 parameters required by the PDSF, this IDL
   ;  function computes
   ;
   ;  *   the value of the first Parametric Sine Function (PSF1) at
   ;      argument x on the basis of parameters params[1] to params[3],
   ;
   ;  *   the value of the second Parametric Sine Function (PSF2) at
   ;      argument x on the basis of parameters params[4] to params[6],
   ;      and
   ;
   ;  *   the value of the Parametric Double Sine Function (PSF3) at
   ;      argument x as PSF3 = params[0] + PSF1 + PSF2.
   ;
   ;  where the elements of params have the following meanings:
   ;
   ;  *   a [0] = Base value of the PDSF, i.e., asymptotic value when x
   ;      tends to −infinity.
   ;
   ;  *   a [1] = Amplitude of the PSF1 (independently from the base
   ;      value).
   ;
   ;  *   a [2] = Phase shift along the x axis for the start of the PSF1:
   ;      a positive (negative) value shifts the function to the right
   ;      (left) of x = 0.
   ;
   ;  *   a [3] = Phase shift along the x axis for the end of the PSF1: a
   ;      positive (negative) value shifts the function to the right
   ;      (left) of x = 0.
   ;
   ;  *   a [4] = Amplitude of the PSF2 (independently from the base
   ;      value).
   ;
   ;  *   a [5] = Phase shift along the x axis for the start of the PSF2:
   ;      a positive (negative) value shifts the function to the right
   ;      (left) of x = 0.
   ;
   ;  *   a [6] = Phase shift along the x axis for the end of the PSF2: a
   ;      positive (negative) value shifts the function to the right
   ;      (left) of x = 0.
   ;
   ;  SYNTAX: rc = pdsf(x, params, psf1, psf2, psf3, $
   ;  DEBUG = debug, EXCPT_COND = excpt_cond)
   ;
   ;  POSITIONAL PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   x {FLOAT} [I]: The argument of the PDSF.
   ;
   ;  *   params {FLOAT array} [I]: The array of 7 parameters of the PDSF.
   ;
   ;  *   phtf1 {FLOAT} [O]: The value of the first Parametric Sine
   ;      Function (PSF1) at argument x on the basis of parameters
   ;      params[1] to params[3].
   ;
   ;  *   phtf2 {FLOAT} [O]: The value of the second Parametric Sine
   ;      Function (PSF2) at argument x on the basis of parameters
   ;      params[4] to params[6].
   ;
   ;  *   phtf3 {FLOAT} [O]: The value of the Parametric Double Sine
   ;      Function (PSF3) at argument x, computed PSF3 = params[0] +
   ;      PSF1 + PSF2.
   ;
   ;  KEYWORD PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   DEBUG = debug {INT} [I] (Default value: 0): Flag to activate (1)
   ;      or skip (0) debugging tests.
   ;
   ;  *   EXCPT_COND = excpt_cond {STRING} [O] (Default value: ”):
   ;      Description of the exception condition if one has been
   ;      encountered, or a null string otherwise.
   ;
   ;  RETURNED VALUE TYPE: INT [or N/A].
   ;
   ;  OUTCOME:
   ;
   ;  *   If no exception condition has been detected, this function
   ;      returns 0, and the output keyword parameter excpt_cond is set to
   ;      a null string, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided in the call. The output positional parameters psf1,
   ;      psf2 and psf3 provide the values of the 2 constitutive
   ;      contributions as well as final value of the PDSF, at argument x,
   ;      given the array of 7 parameters params.
   ;
   ;  *   If an exception condition has been detected, this function
   ;      returns a non-zero error code, and the output keyword parameter
   ;      excpt_cond contains a message about the exception condition
   ;      encountered, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided. The values of the output positional parameters psf1,
   ;      psf2 and psf3 may be incorrect.
   ;
   ;  EXCEPTION CONDITIONS:
   ;
   ;  *   Error 100: One or more positional parameter(s) are missing.
   ;
   ;  *   Error 110: The input positional parameter x must be numeric.
   ;
   ;  *   Error 120: The input positional parameter params must be a
   ;      numeric array of 7 elements.
   ;
   ;  DEPENDENCIES:
   ;
   ;  *   is_array.pro
   ;
   ;  *   is_numeric.pro
   ;
   ;  *   strstr.pro
   ;
   ;  REMARKS:
   ;
   ;  *   NOTE 1: This routine does not provide the partial derivatives of
   ;      the PDLF.
   ;
   ;  *   NOTE 2: If the input positional parameters x or params are
   ;      provided in DOUBLE precision, the result will also be in DOUBLE
   ;      precision.
   ;
   ;  *   NOTE 3: If the input positional parameters x is an array, the
   ;      output positional parameters psf1, psf2 and psf3 will also be
   ;      arrays of the same dimensions.
   ;
   ;  EXAMPLES:
   ;
   ;      [Insert the command and its outcome]
   ;
   ;  REFERENCES: None.
   ;
   ;  VERSIONING:
   ;
   ;  *   2019–10–05: Version 1.0 — Initial public release.
   ;
   ;  *   2019–10–06: Version 2.0.0 — Documentation update and adoption of
   ;      current coding standards.
   ;Sec-Lic
   ;  INTELLECTUAL PROPERTY RIGHTS
   ;
   ;  *   Copyright (C) 2017-2019 Michel M. Verstraete.
   ;
   ;      Permission is hereby granted, free of charge, to any person
   ;      obtaining a copy of this software and associated documentation
   ;      files (the “Software”), to deal in the Software without
   ;      restriction, including without limitation the rights to use,
   ;      copy, modify, merge, publish, distribute, sublicense, and/or
   ;      sell copies of the Software, and to permit persons to whom the
   ;      Software is furnished to do so, subject to the following three
   ;      conditions:
   ;
   ;      1. The above copyright notice and this permission notice shall
   ;      be included in its entirety in all copies or substantial
   ;      portions of the Software.
   ;
   ;      2. THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
   ;      KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
   ;      WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
   ;      AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
   ;      HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
   ;      WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   ;      FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
   ;      OTHER DEALINGS IN THE SOFTWARE.
   ;
   ;      See: https://opensource.org/licenses/MIT.
   ;
   ;      3. The current version of this Software is freely available from
   ;
   ;      https://github.com/mmverstraete.
   ;
   ;  *   Feedback
   ;
   ;      Please send comments and suggestions to the author at
   ;      MMVerstraete@gmail.com
   ;Sec-Cod

   COMPILE_OPT idl2, HIDDEN

   ;  Get the name of this routine:
   info = SCOPE_TRACEBACK(/STRUCTURE)
   rout_name = info[N_ELEMENTS(info) - 1].ROUTINE

   ;  Initialize the default return code:
   return_code = 0

   ;  Set the default values of flags and essential keyword parameters:
   IF (KEYWORD_SET(debug)) THEN debug = 1 ELSE debug = 0
   excpt_cond = ''

   IF (debug) THEN BEGIN

   ;  Return to the calling routine with an error message if one or more
   ;  positional parameters are missing:
      n_reqs = 5
      IF (N_PARAMS() NE n_reqs) THEN BEGIN
         error_code = 100
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': Routine must be called with ' + strstr(n_reqs) + $
            ' positional parameter(s): x, params, psf1, psf2, psf3.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'x' is not numeric:
      IF (is_numeric(x) NE 1) THEN BEGIN
         error_code = 110
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter x must be numeric.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'a' is not a numeric array of 7 elements:
      IF ((is_numeric(params) NE 1) OR $
         (is_array(params) NE 1) OR $
         (N_ELEMENTS(params) NE 7)) THEN BEGIN
         error_code = 120
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter params must be a numeric ' + $
            'array of 7 elements.'
         RETURN, error_code
      ENDIF
   ENDIF

   ;  Compute the value of the first PDSF term. The sine function varies
   ;  from -1 to +1:
   IF (x LT params[2]) THEN temp = 0.0
   IF ((x GE params[2]) AND (x LE params[3])) THEN BEGIN
      temp = -(!PI / 2.0) + ((x - params[2]) / (params[3] - params[2])) * !PI
      temp = (1.0 + SIN(temp)) / 2.0
   ENDIF
   IF (x GT params[3]) THEN temp = 1.0
   psf1 = params[1] * temp

   ;  Compute the value of the second PDSF term (same principle):
   IF (x LT params[5]) THEN temp = 0.0
   IF ((x GE params[5]) AND (x LE params[6])) THEN BEGIN
      temp = (!PI / 2.0) + ((x - params[5]) / (params[6] - params[5]) * !PI)
      temp = (SIN(temp) - 1.0) / 2.0
   ENDIF
   IF (x GT params[6]) THEN temp = -1.0
   psf2 = - params[4] * temp

   ;  Compute the final value of the PDLF as the sum of those contributions
   ;  plus the base value:
   psf3 = params[0] + psf1 + psf2

   RETURN, return_code

END
