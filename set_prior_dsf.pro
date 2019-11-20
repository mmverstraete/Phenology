FUNCTION set_prior_dsf, $
   x, $
   y, $
   model_p, $
   params, $
   VERBOSE = verbose, $
   DEBUG = debug, $
   EXCPT_COND = excpt_cond

   ;Sec-Doc
   ;  PURPOSE: This function assigns prior values to the 7 parameters of
   ;  the selected double S-shaped model, which is intended to simulate a
   ;  signal that typically goes from low to high to low values, as would
   ;  be the case for a bio-geophysical variable describing the time
   ;  evolution of a single growing season.
   ;
   ;  ALGORITHM: This function analyses the input data record contained in
   ;  the positional parameters x and y, and establishes suitable prior
   ;  values for the 7 parameters of one of the recognized the parametric
   ;  model identified as model_p.
   ;
   ;  SYNTAX: rc = set_prior_dsf(x, y, model_p, params, $
   ;  VERBOSE = verbose, DEBUG = debug, EXCPT_COND = excpt_cond)
   ;
   ;  POSITIONAL PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   x {FLOAT array} [I]: The abscissas of the measurements to which
   ;      the model must be fitted.
   ;
   ;  *   y {FLOAT array} [I]: The ordinates of the measurements to which
   ;      the model must be fitted.
   ;
   ;  *   model_p {STRING} [I]: The name of the IDL procedure that
   ;      computes the value of one of the recognized models at argument
   ;      x.
   ;
   ;  *   params {FLOAT array} [O]: The array of 7 parameters of the
   ;      model_p procedure.
   ;
   ;  KEYWORD PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   VERBOSE = verbose {INT} [I] (Default value: 0): Flag to enable
   ;      (> 0) or skip (0) outputting messages on the console:
   ;
   ;      -   If verbose > 0, messages inform the user about progress in
   ;          the execution of time-consuming routines, or the location of
   ;          output files (e.g., log, map, plot, etc.);
   ;
   ;      -   If verbose > 1, messages record entering and exiting the
   ;          routine; and
   ;
   ;      -   If verbose > 2, messages provide additional information
   ;          about intermediary results.
   ;
   ;  *   DEBUG = debug {INT} [I] (Default value: 0): Flag to activate (1)
   ;      or skip (0) debugging tests.
   ;
   ;  *   EXCPT_COND = excpt_cond {STRING} [O] (Default value: ”):
   ;      Description of the exception condition if one has been
   ;      encountered, or a null string otherwise.
   ;
   ;  RETURNED VALUE TYPE: INT.
   ;
   ;  OUTCOME:
   ;
   ;  *   If no exception condition has been detected, this function
   ;      returns 0, and the output keyword parameter excpt_cond is set to
   ;      a null string, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided in the call. The output positional parameter params
   ;      contains the results generated by this function.
   ;
   ;  *   If an exception condition has been detected, this function
   ;      returns a non-zero error code, and the output keyword parameter
   ;      excpt_cond contains a message about the exception condition
   ;      encountered, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided. The output positional parameter params may be
   ;      incorrect.
   ;
   ;  EXCEPTION CONDITIONS:
   ;
   ;  *   Error 100: One or more positional parameter(s) are missing.
   ;
   ;  *   Error 110: The input positional parameter x is not a numeric
   ;      array with at least 10 elements.
   ;
   ;  *   Error 120: The input positional parameter y is not a numeric
   ;      array with at least 10 elements.
   ;
   ;  *   Error 130: The input positional parameters x and y are of
   ;      different sizes.
   ;
   ;  *   Error 140: The input positional parameter model_p is not a
   ;      string.
   ;
   ;  *   Error 150: The input positional parameter model_p is not
   ;      recognized.
   ;
   ;  DEPENDENCIES:
   ;
   ;  *   is_array.pro
   ;
   ;  *   is_numeric.pro
   ;
   ;  *   is_string.pro
   ;
   ;  *   strstr.pro
   ;
   ;  REMARKS:
   ;
   ;  *   NOTE 1: The results of an inversion procedure tend to depend
   ;      strongly on the choice of the the prior values of the model
   ;      parameters. This function fulfills that purpose, but must know
   ;      what model is being considered to generate appropriate prior
   ;      values. For this reason, the model name (i.e., the name of the
   ;      IDL procedure that implements it) must be recognized by this
   ;      function. If a new model needs to be used, this function must be
   ;      updated to add a code fragment in the CASE statement to properly
   ;      handle the requirements of this new model.
   ;
   ;  EXAMPLES:
   ;
   ;      IDL> x = [-15.0, -10.0, -5.0, 0.0, 5.0, 7.5, $
   ;         10.0, 12.5, 15.0, 18.0, 20.0, 22.0, $
   ;         25.0, 30.0, 35.0, 40.0, 45.0, 50.0]
   ;      IDL> y = [0.32, 0.25, 0.32, 0.28, 0.30, 0.61, $
   ;         1.50, 2.00, 2.35, 2.45, 2.00, 1.62, $
   ;         1.20, 0.68, 0.22, 0.19, 0.23, 0.19]
   ;      IDL> model_p = 'PD_Gaus_P'
   ;      IDL> rc = set_prior_dsf(x, y, model_p, params)
   ;      IDL> PRINT, 'params = ', params
   ;      params = 0.346667 1.52762 10.0000 3.50000 -1.57229 25.0000 4.00000
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
   ;  *   2019–11–08: Version 2.0.0 — Update the documentation and adopt
   ;      the current coding standards.
   ;
   ;  *   2019–11–18: Version 2.0.1 — Add the reference to the _User
   ;      Manual_.
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
   IF (KEYWORD_SET(verbose)) THEN BEGIN
      IF (is_numeric(verbose)) THEN verbose = FIX(verbose) ELSE verbose = 0
      IF (verbose LT 0) THEN verbose = 0
      IF (verbose GT 3) THEN verbose = 3
   ENDIF ELSE verbose = 0
   IF (KEYWORD_SET(debug)) THEN debug = 1 ELSE debug = 0
   excpt_cond = ''

   IF (verbose GT 1) THEN PRINT, 'Entering ' + rout_name + '.'

   IF (debug) THEN BEGIN

   ;  Return to the calling routine with an error message if one or more
   ;  positional parameters are missing:
      n_reqs = 4
      IF (N_PARAMS() NE n_reqs) THEN BEGIN
         error_code = 100
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': Routine must be called with ' + strstr(n_reqs) + $
            ' positional parameter(s): x, y, model_p, params.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'x' is not a numeric array with at least 10
   ;  elements:
      rc1 = is_numeric(x)
      rc2 = is_array(x)
      n_x = N_ELEMENTS(x)
      IF ((rc1 NE 1) OR (rc2 NE 1) OR (n_x LT 10)) THEN BEGIN
         error_code = 110
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter x is not a numeric array ' + $
            'with at least 10 elements.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'y' is not a numeric array with at least 10
   ;  elements:
      rc1 = is_numeric(y)
      rc2 = is_array(y)
      n_y = N_ELEMENTS(y)
      IF ((rc1 NE 1) OR (rc2 NE 1) OR (n_y LT 10)) THEN BEGIN
         error_code = 120
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter y is not a numeric array ' + $
            'with at least 10 elements.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameters 'x' and 'y' are of different sizes:
      IF (n_x NE n_y) THEN BEGIN
         error_code = 130
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameters x and y are of different sizes.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'model_p' is not a STRING:
      rc = is_string(model_p)
      IF (rc NE 1) THEN BEGIN
         error_code = 140
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter model_p is not a string.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'model_p' is not recognized:
      IF ((model_p NE 'PD_Gaus_P') AND $
         (model_p NE 'PD_HyTg_P') AND $
         (model_p NE 'PD_Logi_P') AND $
         (model_p NE 'PD_Sine_P')) THEN BEGIN
         error_code = 150
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter model_p is not recognized.'
         RETURN, error_code
      ENDIF
   ENDIF

   ;  Define the output positional parameter 'params':
   params = FLTARR(7)

   ;  Set the minimum, maximum and mid-point values in the data record:
   min_y = MIN(y, MAX = max_y)
   mid_y = (max_y - min_y) / 2.0

   ;  Identify three segments in the measurement record.

   ;  1. Set the x and y values of the first and last values during the high
   ;  period:
   during = WHERE(y GE mid_y, n_during)

   ;IF (verbose GT 2) THEN PRINT, 'Indices during = ', during
   fst_x_during = x[during[0]]
   fst_y_during = y[during[0]]
   lst_x_during = x[during[N_ELEMENTS(during) - 1]]
   lst_y_during = y[during[N_ELEMENTS(during) - 1]]

   ;  Set the x and y values of the first and last maxima within 'during':
   max_y_during = MAX(y[during])
   idx = WHERE(y EQ max_y_during, n_max_y_during)
   n_max_y_during = MIN([n_max_y_during, 2])
   CASE n_max_y_during OF
      2: BEGIN
         x_fst_max_y_during = x[idx[0]]
         y_fst_max_y_during = y[idx[0]]
         x_lst_max_y_during = x[idx[N_ELEMENTS(idx) - 1]]
         y_lst_max_y_during = y[idx[N_ELEMENTS(idx) - 1]]
      END
      1: BEGIN
         x_fst_max_y_during = x[idx[0]]
         y_fst_max_y_during = y[idx[0]]
         x_lst_max_y_during = x[idx[0]]
         y_lst_max_y_during = y[idx[0]]
      END
      ELSE: BEGIN
         PRINT, 'No maxima found in the during period.'
      END
   ENDCASE

   ;  2. Set the x and y values of the last measurement before the high period:
   before = WHERE((x LT fst_x_during) AND (y LE mid_y), n_before)

   ;IF (verbose GT 2) THEN PRINT, 'Indices before = ', before
   lst_x_before = x[before[N_ELEMENTS(before) - 1]]
   lst_y_before = y[before[N_ELEMENTS(before) - 1]]

   ;  3. Set the x and y values of the first measurement after the GS:
   after = WHERE((x GT lst_x_during) AND (y LE mid_y), n_after)

   ;IF (verbose GT 2) THEN PRINT, 'Indices after = ', after
   fst_x_after = x[after[0]]
   fst_y_after = y[after[0]]

   IF (verbose GT 2) THEN BEGIN
      fmt = '(A30, A)'
      PRINT, 'Last x before = ', strstr(lst_x_before), FORMAT = fmt
      PRINT, 'Last y before = ', strstr(lst_y_before), FORMAT = fmt
      PRINT, 'First x during = ', strstr(fst_x_during), FORMAT = fmt
      PRINT, 'First y during = ', strstr(fst_y_during), FORMAT = fmt
      PRINT, 'x first max during = ', strstr(x_fst_max_y_during), FORMAT = fmt
      PRINT, 'y first max during = ', strstr(y_fst_max_y_during), FORMAT = fmt
      PRINT, 'x last max during = ', strstr(x_lst_max_y_during), FORMAT = fmt
      PRINT, 'y last max during = ', strstr(y_lst_max_y_during), FORMAT = fmt
      PRINT, 'Last x during = ', strstr(lst_x_during), FORMAT = fmt
      PRINT, 'Last y during = ', strstr(lst_y_during), FORMAT = fmt
      PRINT, 'First x after = ', strstr(fst_x_after), FORMAT = fmt
      PRINT, 'First y after = ', strstr(fst_y_after), FORMAT = fmt
   ENDIF

   ;  Compute the mean 'low' value before the high period:
   mean_before = MEAN(y[before[0]:before[N_ELEMENTS(before) - 1]])

   ;  Compute the mean 'high' value:
   mean_during = MEAN(y[during[0]:during[N_ELEMENTS(during) - 1]])

   ;  Compute the mean 'low' value after the high period:
   mean_after = MEAN(y[after[0]:after[N_ELEMENTS(after) - 1]])

   ; IF (verbose GT 2) THEN BEGIN
   ;    fmt = '(A30, A)'
   ;    PRINT, 'Mean before = ', strstr(mean_before), FORMAT = fmt
   ;    PRINT, 'Mean during = ', strstr(mean_during), FORMAT = fmt
   ;    PRINT, 'Mean after = ', strstr(mean_after), FORMAT = fmt
   ; ENDIF

   ;  Set the values of the parameters common to all models.
   ;  params[0] is the base level of the double S-shaped function:
   params[0] = mean_before

   ;  params[1] is the amplitude of the first S-shaped function:
   params[1] = mean_during - mean_before

   ;  params[2] is the amplitude of the second S-shaped function:
   params[4] = mean_after - mean_during

   ;  Set the model-specific prior values of the parameters.
   CASE model_p OF
      'PD_Gaus_P': BEGIN

   ;  params[2] is the phase of the first S-shaped function; in the case of
   ;  'PD_Gaus_P', this is the 'x' of the first high value in 'during':
         params[2] = fst_x_during

   ;  params[3] is the slope of the first S-shaped function; in the case of
   ;  'PD_Gaus_P', this is the standard deviation of the Gaussian, here
   ;  estimated as 1/3 of the length of the period between the 'x' of the
   ;  first maximum value in 'during' and the last 'x' value in 'before':
         params[3] = (x_fst_max_y_during - lst_x_before) / 3.0
         ;(fst_x_during - lst_x_before) / 3.0

   ;  params[5] is the phase of the second S-shaped function; in the case of
   ;  'PD_Gaus_P', this is the 'x' of the last high value in 'during':
         params[5] = lst_x_during

   ;  params[6] is the slope of the second S-shaped function; in the case of
   ;  'PD_Gaus_P', this is the standard deviation of the Gaussian, here
   ;  estimated as 1/3 of the length of the period between the first 'x' value
   ;  in 'after' and the 'x' of the last maximum value in 'during' :
         params[6] = (fst_x_after - x_lst_max_y_during) / 3.0
         ;(lst_x_during - fst_x_after) / 3.0
         ;
      END
      'PD_HyTg_P': BEGIN

   ;  params[2] is the phase of the first S-shaped function; in the case of
   ;  'PD_HyTg_P', this is the 'x' value of the inflexion point, hence the
   ;  mid-point between the 'x' of the first high value in 'during' and the
   ;  'x' value of the last low value in 'before':
         params[2] = lst_x_before + ((fst_x_during - lst_x_before) / 2.0)

   ;  params[3] is the slope of the first S-shaped function; in the case of
   ;  'PD_HyTg_P', this is slope of the straight line between the last low
   ;  value in 'before' and the first high value in 'during':
         params[3] = (fst_y_during - lst_y_before) / $
            (fst_x_during - lst_x_before)

   ;  params[5] is the phase of the second S-shaped function; in the case of
   ;  'PD_HyTg_P', this is the 'x' value of the inflexion point, hence the
   ;  mid-point between the 'x' of the first low value in 'after' and the 'x'
   ;  value of the last high value in 'during':
         params[5] = lst_x_during + ((fst_x_after - lst_x_during) / 2.0)

   ;  params[6] is the slope of the first S-shaped function; in the case of
   ;  'PD_HyTg_P', this is slope of the straight line between the last high
   ;  value in 'during' and the first low value in 'after':
         params[6] = ABS((lst_y_during - fst_y_after) / $
            (lst_x_during - fst_x_after))
      END
      'PD_Logi_P': BEGIN

   ;  params[2] is the phase of the first S-shaped function; in the case of
   ;  'PD_Logi_P', this is the 'x' value of the inflexion point, hence the
   ;  mid-point between the 'x' of the first high value in 'during' and the
   ;  'x' value of the last low value in 'before':
         params[2] = lst_x_before + ((fst_x_during - lst_x_before) / 2.0)

   ;  params[3] is the slope of the first S-shaped function; in the case of
   ;  'PD_Logi_P', this is ...
         params[3] = 2.0 * (fst_y_during - lst_y_before) / $
            (fst_x_during - lst_x_before)

   ;  params[5] is the phase of the second S-shaped function; in the case of
   ;  'PD_Logi_P', this is the 'x' value of the inflexion point, hence the
   ;  mid-point between the 'x' of the first low value in 'after' and the 'x'
   ;  value of the last high value in 'during':
         params[5] = lst_x_during + ((fst_x_after - lst_x_during) / 2.0)

   ;  params[6] is the slope of the first S-shaped function; in the case of
   ;  'PD_Logi_P', this is ...
         params[6] = 2.0 * (fst_y_during - lst_y_before) / $
            (fst_x_during - lst_x_before)

      END
      'PD_Sine_P': BEGIN

   ;  params[2] is the phase of the start of first S-shaped function; hence
   ;  the last measurement before the high period:
         params[2] = lst_x_before

   ;  params[3] is the phase of the end of first S-shaped function; hence
   ;  the first measurement during the high period:
         params[3] = x_fst_max_y_during

   ;  params[5] is the phase of the start of second S-shaped function; hence
   ;  the last measurement during the high period:
         params[5] = x_lst_max_y_during

   ;  params[6] is the phase of the end of second S-shaped function; hence
   ;  the first measurement after the high period:
         params[6] = fst_x_after
      END
   ENDCASE

   IF (verbose GT 1) THEN PRINT, 'Exiting ' + rout_name + '.'

   RETURN, return_code

END
