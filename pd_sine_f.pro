FUNCTION pd_sine_f, $
   x, $
   params, $
   psf1, $
   psf2, $
   DOUBLE = double, $
   DEBUG = debug, $
   EXCPT_COND = excpt_cond

   ;Sec-Doc
   ;  PURPOSE: This IDL function returns the value of the Parametric
   ;  Double Sine Function at argument x, given the array params of 7
   ;  parameters, and provides the values of its 2 S-shaped functional
   ;  components in the output positional parameters psf1 and psf2.
   ;
   ;  ALGORITHM: Given the input positional parameters x (scalar or array)
   ;  and the array params of 7 parameters, this function computes the
   ;  value of the Parametric Double Sine Function (PDSF) and the 2
   ;  components psf1 and psf2.
   ;
   ;  SYNTAX: res = pd_sine_f(x, params, psf1, psf2, $
   ;  DOUBLE = double, DEBUG = debug, EXCPT_COND = excpt_cond)
   ;
   ;  POSITIONAL PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   x {FLOAT scalar or array} [I]: The argument of the pd_sine_f
   ;      function.
   ;
   ;  *   params {FLOAT array} [I]: The array of 7 parameters of the
   ;      pd_sine_f function.
   ;
   ;  *   psf1 {FLOAT scalar or array} [O]: The value of the first
   ;      Parametric Sine Function at argument x on the basis of
   ;      parameters params[1] to params[3].
   ;
   ;  *   psf2 {FLOAT scalar or array} [O]: The value of the second
   ;      Parametric Sine Function at argument x on the basis of
   ;      parameters params[4] to params[6].
   ;
   ;  KEYWORD PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   DOUBLE = double {INT} [I] (Default value: 0): Flag to activate
   ;      (1) or skip (0) computing in double precision.
   ;
   ;  *   DEBUG = debug {INT} [I] (Default value: 0): Flag to activate (1)
   ;      or skip (0) debugging tests.
   ;
   ;  *   EXCPT_COND = excpt_cond {STRING} [O] (Default value: ”):
   ;      Description of the exception condition if one has been
   ;      encountered, or a null string otherwise.
   ;
   ;  RETURNED VALUE TYPE: FLOAT (scalar or array).
   ;
   ;  OUTCOME:
   ;
   ;  *   If no exception condition has been detected, this function
   ;      returns the scalar or array value res of the Parametric Double
   ;      Sine Function at argument x, given the array of 7 parameters
   ;      params. The output positional parameters psf1 and psf2 provide
   ;      the values of the 2 constitutive contributions for the same
   ;      argument. The output keyword parameter excpt_cond is set to a
   ;      null string, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided in the call.
   ;
   ;  *   If an exception condition has been detected, the return value
   ;      res and the values of the output positional parameters psf1 and
   ;      psf2 may be incorrect. The output keyword parameter excpt_cond
   ;      contains a message about the exception condition encountered, if
   ;      the optional input keyword parameter DEBUG is set and if the
   ;      optional output keyword parameter EXCPT_COND is provided.
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
   ;      the Parametric Double Sine Function with respect to the model
   ;      parameters; use the procedure pd_sine_p for that purpose.
   ;
   ;  *   NOTE 2: Set the optional input keyword parameter DOUBLE to carry
   ;      out all computations in double precision.
   ;
   ;  *   NOTE 3: If the input positional parameters x is an array, the
   ;      return value res and the output positional parameters psf1 and
   ;      psf2 will also be arrays of the same dimensions.
   ;
   ;  *   NOTE 4: The asymptotic value of pd_logi_f when x →  + ∞ is
   ;      params[0] + params[1] + params[4].
   ;
   ;  EXAMPLES:
   ;
   ;      IDL> x = 17.0
   ;      IDL> params = [1.0, 3.0, 0.0, 10.0, -2.5, 20.0, 35.0]
   ;      IDL> res = pd_sine_f(x, params, psf1, psf2, $
   ;         DEBUG = debug, EXCPT_COND = excpt_cond)
   ;      IDL> PRINT, 'res = ' + strstr(res)
   ;      res = 4.00000
   ;
   ;  REFERENCES:
   ;
   ;  *   Michel M. Verstraete (2019) _User Manual for the Phenology
   ;      package_.
   ;
   ;  VERSIONING:
   ;
   ;  *   2019–10–05: Version 1.0 — Initial public release.
   ;
   ;  *   2019–11–08: Version 2.0.0 — Modify the code to return the
   ;      function value instead of an error code, update the
   ;      documentation and adopt the current coding standards.
   ;
   ;  *   2019–11–18: Version 2.0.1 — Remove the detailed mathematical
   ;      description of the algorithm from the IDL function and add it to
   ;      the _User Manual_, add the reference to that manual.
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
   IF (KEYWORD_SET(double)) THEN double = 1 ELSE double = 0
   IF (KEYWORD_SET(debug)) THEN debug = 1 ELSE debug = 0
   excpt_cond = ''

   IF (debug) THEN BEGIN

   ;  Return to the calling routine with an error message if one or more
   ;  positional parameters are missing:
      n_reqs = 4
      IF (N_PARAMS() NE n_reqs) THEN BEGIN
         error_code = 100
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': Routine must be called with ' + strstr(n_reqs) + $
            ' positional parameter(s): x, params, psf1, psf2.'
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

   ;  Determine the dimension of the the input positional parameter 'x':
   n_pts = N_ELEMENTS(x)

   ;  Recast the inputs as DOUBLE variables, if requested, and define the
   ;  output positional parameters 'psf1', 'psf2' and 'pdsf' accordingly:
   IF (double) THEN BEGIN
      x = DOUBLE(x)
      params = DOUBLE(params)
      psf1 = DBLARR(n_pts)
      psf2 = DBLARR(n_pts)
      pdsf = DBLARR(n_pts)
   ENDIF ELSE BEGIN
      psf1 = FLTARR(n_pts)
      psf2 = FLTARR(n_pts)
      pdsf = FLTARR(n_pts)
   ENDELSE

   ;  Compute the value of the 'psf1' term. The sine function varies
   ;  from -1 to +1, so SIN+1 varies from 0 to 2, and
   ;  (SIN+1)/2 varies from 0 to 1:
   ;temp = 0.0
   FOR i = 0, n_pts - 1 DO BEGIN
      CASE 1 OF
         (x[i] LE params[2]): temp = 0.0
         (x[i] GE params[3]): temp = 1.0
         ELSE: BEGIN
            temp = (SIN(-(!PI / 2.0) + $
               ((x[i] - params[2])/(params[3] - params[2])) * !PI) + 1.0) / 2.0
         END
      ENDCASE
      ; IF (x[i] LT params[2]) THEN temp = 0.0
      ; IF ((x[i] GE params[2]) AND (x[i] LE params[3])) THEN BEGIN
      ;    temp = -(!PI / 2.0) + $
      ;       ((x[i] - params[2]) / (params[3] - params[2])) * !PI
      ;    temp = (1.0 + SIN(temp)) / 2.0
      ; ENDIF
      ; IF (x[i] GT params[3]) THEN temp = 1.0
      psf1[i] = params[1] * temp

   ;  Compute the value of the 'psf2' term. The sine function varies
   ;  from -1 to +1, so SIN+1 varies from 0 to 2, and
   ;  (SIN+1)/2 varies from 0 to 1:
      CASE 1 OF
         (x[i] LE params[5]): temp = 0.0
         (x[i] GE params[6]): temp = 1.0
         ELSE: BEGIN
            temp = (SIN(-(!PI / 2.0) + $
               ((x[i] - params[5])/(params[6] - params[5])) * !PI) + 1.0) / 2.0
         END
      ENDCASE

      ; IF (x[i] LT params[5]) THEN temp = 0.0
      ; IF ((x[i] GE params[5]) AND (x[i] LE params[6])) THEN BEGIN
      ;    temp = (!PI / 2.0) + $
      ;       ((x[i] - params[5]) / (params[6] - params[5])) * !PI
      ;    temp = (SIN(temp) - 1.0) / 2.0
      ; ENDIF
      ; IF (x[i] GT params[6]) THEN temp = -1.0
      psf2[i] = params[4] * temp
   ENDFOR

   ;  Compute the final value of 'pdsf' as the sum of those contributions
   ;  plus the base value:
   pdsf = params[0] + psf1 + psf2

   RETURN, pdsf

END
