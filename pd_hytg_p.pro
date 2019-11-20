PRO pd_hytg_p, $
   x, $
   params, $
   pdhtp, $
   pder, $
   DOUBLE = double, $
   DEBUG = debug, $
   EXCPT_COND = excpt_cond

   ;Sec-Doc
   ;  PURPOSE: This IDL procedure computes the values of the Parametric
   ;  Double Hyperbolic Tangent Function and of its partial derivatives
   ;  with respect to the model parameters at argument x.
   ;
   ;  ALGORITHM: Given the input positional parameters x (scalar or array)
   ;  and the array params of 7 parameters, this function computes the
   ;  value pdhtp of the Parametric Double Hyperbolic Tangent Function
   ;  (PDHyTgF) and the values pder of the partial derivatives of that
   ;  function with respect to those parameters.
   ;
   ;  SYNTAX: pd_hytg_p, x, params, pdhtp, pder, $
   ;  DOUBLE = double, DEBUG = debug, EXCPT_COND = excpt_cond)
   ;
   ;  POSITIONAL PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   x {FLOAT scalar or array} [I]: The argument of the pd_hytg_p
   ;      procedure.
   ;
   ;  *   params {FLOAT array} [I]: The array of 7 parameters of the
   ;      pd_hytg_p procedure.
   ;
   ;  *   pdhtp {FLOAT scalar or array} [O]: The value of the Parametric
   ;      Double Hyperbolic Tangent Function at argument x.
   ;
   ;  *   pder {FLOAT array} [O]: The values of the derivatives of the
   ;      Parametric Double Hyperbolic Tangent Function with respect to
   ;      the parameters params at argument x.
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
   ;  RETURNED VALUE TYPE: N/A.
   ;
   ;  OUTCOME:
   ;
   ;  *   If no exception condition has been detected, this procedure
   ;      computes the value pdhtp of the Parametric Double Hyperbolic
   ;      Tangent Function at argument x, given the array of 7 parameters
   ;      params, as well as the derivatives pder of that model at
   ;      argument x with respect to the parameters. The output keyword
   ;      parameter excpt_cond is set to a null string, if the optional
   ;      input keyword parameter DEBUG is set and if the optional output
   ;      keyword parameter EXCPT_COND is provided in the call.
   ;
   ;  *   If an exception condition has been detected, the output
   ;      positional parameters pdhtp and pder may be incorrect. The
   ;      output keyword parameter excpt_cond contains a message about the
   ;      exception condition encountered, if the optional input keyword
   ;      parameter DEBUG is set and if the optional output keyword
   ;      parameter EXCPT_COND is provided.
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
   ;  *   NOTE 1: The optional input and output keyword parameters DOUBLE,
   ;      DEBUG and EXCPT_COND are provided for diagnostic and testing
   ;      purposes, but are ignored by the IDL CURVEFIT function in a
   ;      model inversion process.
   ;
   ;  *   NOTE 2: Set the optional input keyword parameter DOUBLE to carry
   ;      out all computations in double precision.
   ;
   ;  *   NOTE 3: If the input positional parameters x is an array, the
   ;      output positional parameters pdhtp and pder will also be arrays
   ;      of the same dimensions.
   ;
   ;  *   NOTE 4: The computation of Parametric Double Hyperbolic Tangent
   ;      Function implemented in this IDL procedure is slightly different
   ;      than that described in the publications by Meroni et al.
   ;      mentioned below.
   ;
   ;  EXAMPLES:
   ;
   ;      IDL> x = 4.5
   ;      IDL> params = [1.0, 2.0, 3.0, 1.0, -2.0, 6.0, 0.5]
   ;      IDL> pd_hytg_p, x, params, pdhtp, pder, $
   ;         DOUBLE = double, DEBUG = debug, EXCPT_COND = excpt_cond
   ;      IDL> PRINT, 'pdhtp = ', pdhtp
   ;      pdhtp =       2.54030
   ;      IDL> PRINT, 'pder[5] = ', pder[5]
   ;      pder[5] =      0.298293
   ;
   ;  REFERENCES:
   ;
   ;  *   Michel M. Verstraete (2019) _User Manual for the Phenology
   ;      package_.
   ;
   ;  *   Meroni, M., M. M. Verstraete, F. Rembold, F. Urbano and F.
   ;      Kayitakire (2012) ‘Analysis of phenologically-tuned productivity
   ;      anomalies for food security monitoring’, _1st EARSeL Workshop on
   ;      Temporal Analysis of Satellite Images, Mykonos, Greece, 24-25
   ;      May 2012_.
   ;
   ;  *   Meroni, M., Verstraete, M. M., Rembold, F., Urbano, F.,
   ;      Kayitakire, F. (2014) ’A phenology-based method to derive
   ;      biomass production anomalies for food security monitoring in the
   ;      Horn of Africa’, _International Journal of Remote Sensing_, 35,
   ;      2472–2492, doi:10.1080/01431161.2014.883090.
   ;
   ;  *   URL: http://mathworld.wolfram.com/HyperbolicTangent.html,
   ;      accessed on
   ;      2019–11–05.
   ;
   ;  *   URL: https://www.derivative-calculator.net/, accessed on
   ;      2019-11-03.
   ;
   ;  VERSIONING:
   ;
   ;  *   2010–02–19: Version 0.9 — Initial release of the pdhtf.pro
   ;      procedure.
   ;
   ;  *   2012–05–24: Version 1.0 — Initial public release.
   ;
   ;  *   2019–11–06: Version 2.0.0 — Rename the procedure pd_hytg_p.pro,
   ;      include the derivative computations, document the update, and
   ;      adopt the current coding standards.
   ;
   ;  *   2019–11–18: Version 2.0.1 — Remove the detailed mathematical
   ;      description of the algorithm from the IDL procedure and add it
   ;      to the _User Manual_, add the reference to that manual.
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
            ' positional parameter(s): x, params, pdhtp, pder.'
         PRINT, error_code
         RETURN
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'x' is not numeric:
      IF (is_numeric(x) NE 1) THEN BEGIN
         error_code = 110
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter x must be numeric.'
         PRINT, error_code
         RETURN
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
         PRINT, error_code
         RETURN
      ENDIF
   ENDIF

   ;  Determine the dimensions of the the input positional parameter 'x' and
   ;  'params':
   n_pts = N_ELEMENTS(x)
   n_par = N_ELEMENTS(params)

   ;  Recast the inputs as DOUBLE variables, if requested, define the
   ;  array of partial derivatives of the model with respect to the
   ;  parameters, and call the corresponding 'pd_hytg_f' function to estimate
   ;  the value of the Parametric Double Hyperbolic Tangent Function at
   ;  argument x:
   IF (double) THEN BEGIN
      x = DOUBLE(x)
      params = DOUBLE(params)
      pder = MAKE_ARRAY(n_pts, n_par, /DOUBLE, VALUE = 0.0D)
      pdhtp = pd_hytg_f(x, params, phtf1, phtf2, /DOUBLE, $
         DEBUG = debug, EXCPT_COND = excpt_cond)
   ENDIF ELSE BEGIN
      pder = MAKE_ARRAY(n_pts, n_par, /FLOAT, VALUE = 0.0)
      pdhtp = pd_hytg_f(x, params, phtf1, phtf2, $
         DEBUG = debug, EXCPT_COND = excpt_cond)
   ENDELSE

   ;  Compute the derivatives of the Parametric Double Hyperbolic Tangent
   ;  Function with respect to the model parameters at argument x:
   FOR i = 0, n_pts - 1 DO BEGIN

   ;  \partial [f_1(x) + f_2(x)]/\partial p_0:
      pder[i, 0] = 1.0

   ;  Compute the common term for the derivatives of f_1(x):
      coshx23 = COSH((x[i] - params[2]) * params[3])

   ;  \partial f_1(x)/\partial p_1:
      pder[i, 1] = (TANH((x[i] - params[2]) * params[3]) + 1.0) / 2.0

   ;  \partial f_1(x)/\partial p_2:
      pder[i, 2] = -(params[1] * params[3]) / $
         (2.0 * coshx23 * coshx23)

   ;  \partial f_1(x)/\partial p_3:
      pder[i, 3] = (params[1] * (x[i] - params[2])) / $
         (2.0 * coshx23 * coshx23)

   ;  Compute the common term for the derivatives of f_2(x):
      coshx56 = COSH((x[i] - params[5]) * params[6])

   ;  \partial f_2(x)/\partial p_4:
      pder[i, 4] = (TANH((x[i] - params[5]) * params[6]) + 1.0) / 2.0

   ;  \partial f_2(x)/\partial p_5:
      pder[i, 5] = -(params[4] * params[6]) / $
         (2.0 * coshx56 * coshx56)

   ;  \partial f_2(x)/\partial p_6:
      pder[i, 6] = (params[4] * (x[i] - params[5])) / $
         (2.0 * coshx56 * coshx56)
   ENDFOR

END
