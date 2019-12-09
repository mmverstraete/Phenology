FUNCTION fit_dsf, $
   x, $
   y, $
   model_p, $
   params, $
   XTIME = xtime, $
   FROM_X = from_x, $
   TO_X = to_x, $
   FROM_Y = from_y, $
   TO_Y = to_y, $
   ITMAX = itmax, $
   ITER = iter, $
   WEIGHTS = weights, $
   NODERIVATIVE = noderivative, $
   TOL = tol, $
   CHISQ = chisq, $
   YERROR = yerror, $
   STATUS = status, $
   PLOT_IT = plot_it, $
   PLOT_FOLDER = plot_folder, $
   DOUBLE = double, $
   VERBOSE = verbose, $
   DEBUG = debug, $
   EXCPT_COND = excpt_cond

   ;Sec-Doc
   ;  PURPOSE: This function serves as a wrapper to the IDL function
   ;  CURVEFIT: it fits a user-supplied procedure model_p to a series of
   ;  data points and optionally plots the results.
   ;
   ;  ALGORITHM: This function fits the user-supplied procedure model_p to
   ;  a set of points defined by the input positional parameters x and y,
   ;  given prior values of the model parameters params. Upon completion
   ;  of the processing , this array contains the posterior values of
   ;  those parameters.
   ;
   ;  SYNTAX: rc = fit_dsf(x, y, model_p, params, $
   ;  XTIME = xtime, FROM_X = from_x, TO_X = to_x, $
   ;  FROM_Y = from_y, TO_Y = to_y, $
   ;  ITMAX = itmax, ITER = iter, $
   ;  WEIGHTS = weights, NODERIVATIVE = noderivative, $
   ;  TOL = tol, CHISQ = chisq, $
   ;  YERROR = yerror, STATUS = status, $
   ;  PLOT_IT = plot_it, PLOT_FOLDER = plot_folder, $
   ;  DOUBLE = double, VERBOSE = verbose, $
   ;  DEBUG = debug, EXCPT_COND = excpt_cond
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
   ;      computes the value of the model at argument x.
   ;
   ;  *   params {FLOAT array} [I/O]: The array of 7 parameters of the
   ;      pd_hytg_p procedure. On input, params contains the prior values,
   ;      on output it contains the posterior estimates.
   ;
   ;  KEYWORD PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   XTIME = xtime {INT} [I] (Default value: 0): Flag to enable (> 0)
   ;      or skip (0) interpreting the values of the input positional
   ;      parameter x as Julian dates.
   ;
   ;  *   FROM_X = from_x {FLOAT} [I]: The smallest value of the
   ;      independent variable (abscissa) to consider in the plotting of
   ;      the results.
   ;
   ;  *   TO_X = to_x {FLOAT} [I]: The largest value of the independent
   ;      variable (abscissa) to consider in the plotting of the results.
   ;
   ;  *   FROM_Y = from_y {FLOAT} [I] (Default value: MIN(y): The optional
   ;      smallest value of y to be plotted.
   ;
   ;  *   TO_Y = to_y {FLOAT} [I] (Default value: MAX(y): The optional
   ;      largest value of y to be plotted.
   ;
   ;  *   ITMAX = itmax {INT} [I]: The maximum allowed number of
   ;      iterations in the inversion process.
   ;
   ;  *   ITER = iter {INT} [O]: The actual number of iterations in the
   ;      inversion process.
   ;
   ;  *   WEIGHTS = weights {FLOAT array} [I]: The array of weights to be
   ;      assigned to the measurements. If the standard deviation STD
   ;      applicable to each measurement is known, then weight = 1/STD. If
   ;      the measurement uncertainty is unknow, set all weights to 1.0.
   ;      Set the weight to 0.0 if a measurement should not be considered
   ;      in the inversion process.
   ;
   ;  *   NODERIVATIVE = noderivative{INT} [I]: Flag to calculate the
   ;      derivatives numerically (1) or symbolically (0).
   ;
   ;  *   TOL = tol {FLOAT} [I]: The convergence tolerance: the iterative
   ;      inversion process is stopped when the change in χ² becomes
   ;      smaller that this tolerance.
   ;
   ;  *   CHISQ = chisq {FLOAT} [O]: The χ² statistics describing the
   ;      degree of fitness between the model and the data.
   ;
   ;  *   YERROR = yerror {FLOAT} [O]: The standard error between the
   ;      model and the data.
   ;
   ;  *   STATUS = status {INT} [O]: The indicator of the inversion
   ;      outcome: if status = 0, the inversion process was successful, if
   ;      status = 1, the inversion process aborted because χ² kept
   ;      increasing without bounds, and if status = 2, the inversion
   ;      process did not converge satisfactorily after itmax iterations.
   ;
   ;  *   PLOT_IT = plot_it{INT} [I] (Default value: 0): Flag to activate
   ;      (1) or skip (0) generating plots (e.g., of time series).
   ;
   ;  *   PLOT_FOLDER = plot_folder {STRING} [I]: The directory address of
   ;      the output folder containing the plots (e.g., of time series),
   ;      if different from the value implied by the default set by
   ;      function set_roots_vers.pro) and the routine arguments.
   ;
   ;  *   DOUBLE = double {INT} [I] (Default value: 0): Flag to activate
   ;      (1) or skip (0) computing in double precision.
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
   ;  *   Error 150: The input positional parameter params is not a
   ;      numeric array of 7 elements.
   ;
   ;  *   Error 160: The input keyword parameter weights is not a numeric
   ;      array with at least 10 elements.
   ;
   ;  *   Error 170: The input positional parameter x and the input
   ;      keyword parameter weights are of different sizes.
   ;
   ;  *   Error 199: An exception condition occurred in
   ;      set_roots_vers.pro.
   ;
   ;  *   Error 299: Computer is unrecognized, function set_roots_vers.pro
   ;      did not assign default folder values, and the optional keyword
   ;      parameter plot_folder is not specified.
   ;
   ;  *   Error 500: The inversion procedure did not converge.
   ;
   ;  *   Error 502: The inversion procedure did not converge after itmax
   ;      iterations.
   ;
   ;  *   Error 509: Unrecognized status code returned from CURVEFIT.
   ;
   ;  DEPENDENCIES:
   ;
   ;  *   The IDL procedure named model_p.pro
   ;
   ;  *   is_array.pro
   ;
   ;  *   is_numeric.pro
   ;
   ;  *   is_string.pro
   ;
   ;  *   plt_dsf.pro
   ;
   ;  *   round_dec.pro
   ;
   ;  *   set_roots_vers.pro
   ;
   ;  *   strcat.pro
   ;
   ;  *   strstr.pro
   ;
   ;  REMARKS:
   ;
   ;  *   NOTE 1: The outcome of this function is quite sensitive to the
   ;      numer of data points (the more, the better) and to the prior
   ;      values contained in params upon input.
   ;
   ;  EXAMPLES:
   ;
   ;      [Insert the command and its outcome]
   ;
   ;  REFERENCES:
   ;
   ;  *   Michel M. Verstraete (2019) _User Manual for the Phenology
   ;      package_.
   ;
   ;  VERSIONING:
   ;
   ;  *   2010–02–19: Version 0.9 — Initial release.
   ;
   ;  *   2012–05–24: Version 1.0 — Initial public release.
   ;
   ;  *   2019–11–06: Version 2.0.0 — Update the code to accept an
   ;      arbitrary (user-provided) model to be fitted, update the
   ;      documentation and adopt the current coding standards.
   ;
   ;  *   2019–11–18: Version 2.0.1 — Update the code to optionally plot
   ;      the model and the data with the prior and the posterior
   ;      parameters, and add the reference to the _User Manual_.
   ;
   ;  *   2019–11–27: Version 2.0.2 — Update the code to print the correct
   ;      message for error condition 502.
   ;
   ;  *   2019–12–06: Version 2.0.3 — Update the code to include the
   ;      keyword parameter XTIME, used by plt_dsf.pro, provide default
   ;      values for FROM_X and TO_X, and add input keyword parameters
   ;      FROM_y and TO_Y.
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
   IF (KEYWORD_SET(plot_it)) THEN plot_it = 1 ELSE plot_it = 0
   IF (KEYWORD_SET(double)) THEN double = 1 ELSE double = 0
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
      n_pts_x = N_ELEMENTS(x)
      IF ((rc1 NE 1) OR (rc2 NE 1) OR (n_pts_x LT 10)) THEN BEGIN
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
      n_pts_y = N_ELEMENTS(y)
      IF ((rc1 NE 1) OR (rc2 NE 1) OR (n_pts_y LT 10)) THEN BEGIN
         error_code = 120
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter y is not a numeric array ' + $
            'with at least 10 elements.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameters 'x' and 'y' are of different sizes:
      IF (n_pts_x NE n_pts_y) THEN BEGIN
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
   ;  positional parameter 'params' is not a numeric array of 7 elements:
      rc1 = is_numeric(params)
      rc2 = is_array(params)
      n_par = N_ELEMENTS(params)
      IF ((rc1 NE 1) OR (rc2 NE 1) OR (n_par NE 7)) THEN BEGIN
         error_code = 150
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter params is not a numeric ' + $
            'array of 7 elements.'
         RETURN, error_code
      ENDIF

      IF (KEYWORD_SET(weights)) THEN BEGIN

   ;  Return to the calling routine with an error message if the input
   ;  keyword parameter 'weights' is is set and is not a numeric array with
   ;  at least 10 elements:
         rc1 = is_numeric(y)
         rc2 = is_array(y)
         n_wei = N_ELEMENTS(weights)
         IF ((rc1 NE 1) OR (rc2 NE 1) OR (n_wei LT 10)) THEN BEGIN
            error_code = 160
            excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
               ': The input keyword parameter weights is not a numeric ' + $
               'array with at least 10 elements.'
            RETURN, error_code
         ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  keyword parameter 'weights' is set and if its size differs from 'x':
         IF (n_wei NE n_pts_x) THEN BEGIN
            error_code = 170
            excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
               ': The input positional parameter x and the input keyword ' + $
               'parameter weights are of different sizes.'
            RETURN, error_code
         ENDIF
      ENDIF
   ENDIF

   ;  Set the default folders and version identifiers of the MISR and
   ;  MISR-HR files on this computer, and return to the calling routine if
   ;  there is an internal error, but not if the computer is unrecognized, as
   ;  root addresses can be overridden by input keyword parameters:
   rc_roots = set_roots_vers(root_dirs, versions, $
      DEBUG = debug, EXCPT_COND = excpt_cond)
   IF (debug AND (rc_roots GE 100)) THEN BEGIN
      error_code = 199
      excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
         ': ' + excpt_cond
      RETURN, error_code
   ENDIF

   ;  Return to the calling routine with an error message if the routine
   ;  'set_roots_vers.pro' could not assign valid values to the array root_dirs
   ;  and the required MISR and MISR-HR root folders have not been initialized:
   IF (debug AND (rc_roots EQ 99)) THEN BEGIN
      IF (plot_it AND (~KEYWORD_SET(plot_folder))) THEN BEGIN
         error_code = 299
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': Computer is unrecognized, function set_roots_vers.pro did ' + $
            'not assign default folder values, and the optional keyword ' + $
            'parameter plot_folder is not specified.'
      ENDIF
   ENDIF

   ;  Recast the inputs as DOUBLE variables, if requested:
   IF (double) THEN BEGIN
      x = DOUBLE(x)
      y = DOUBLE(y)
      params = DOUBLE(params)
   ENDIF

   ;  Reset the number of data items in the input positional parameters 'x':
   n_pts_x = N_ELEMENTS(x)

   ;  Set the range of the independent variable x to consider, if it is not
   ;  specified explicitly:
   IF (~KEYWORD_SET(from_x)) THEN from_x = MIN(x)
   IF (~KEYWORD_SET(to_x)) THEN to_x = MAX(x)

   ;  Set the weights if they have not been specified:
   IF (~KEYWORD_SET(weights)) THEN $
      weights = MAKE_ARRAY(n_pts_x, /FLOAT, VALUE = 1.0)

   ;  Set the derivative calculation process:
   IF (~KEYWORD_SET(noderivative)) THEN noderivative = 0

   ;  Set the maximum allowed number of iterations:
   IF (~KEYWORD_SET(itmax)) THEN itmax = 20

   ;  Set the tolerance on the convergence of the gradient-expansion algorithm:
   IF (~KEYWORD_SET(tol)) THEN tol = 1.0E-3

   ;  If requested, plot the model with the prior values of the parameters
   ;  and superimpose the measurements:
   IF (plot_it) THEN BEGIN
      model_f = STRMID(model_p, 0, STRLEN(model_p) - 1) + 'F'
      n_plt = 100
      xp = FLTARR(n_plt)
      range_x = to_x - from_x
      incr = range_x / n_plt
      FOR i = 0, n_plt - 1 DO BEGIN
         xp[i] = from_x + (i * incr)
      ENDFOR
      yp = CALL_FUNCTION(model_f, xp, params, pdsf1, pdsf2, $
         DOUBLE = double, DEBUG = debug, EXCPT_COND = excpt_cond)

      params_str = round_dec(params, 2, $
         DEBUG = debug, EXCPT_COND = excpt_cond)
      params_str = strcat(params_str, ', ', $
         DEBUG = debug, EXCPT_COND = excpt_cond)
      iter = -1

      rc = plt_dsf(xp, pdsf1, pdsf2, yp, $
         F_TYPE = model_f, PARAMS_STR = params_str, $
         XTIME = xtime, X_DATA = x, Y_DATA = y, $
         FROM_X = from_x, TO_X = to_x, $
         FROM_Y = from_y, TO_Y = to_y, $
         ITER = iter, CHISQ = chisq, $
         PLOT_IT = plot_it, PLOT_FOLDER = plot_folder, $
         VERBOSE = verbose, DEBUG = debug, EXCPT_COND = excpt_cond)
   ENDIF

   ;  Fit the model_p to the data and generate the posterior values of the
   ;  model parameters:
   iter = 0
   res = CURVEFIT(x, y, weights, params, FUNCTION_NAME = model_p, $
      ITMAX = itmax, TOL = tol, NODERIVATIVE = noderivative, $
      ITER = iter, CHISQ = chisq, YERROR = yerror, STATUS = status)

   IF (debug AND (status NE 0)) THEN BEGIN
      CASE status OF
         1: BEGIN
            error_code = 500
            excpt_cond = 'Error ' + strstr(error_code) + ' in ' + $
               rout_name + ': The chi square statistic increases without bound.'
            END
         2: BEGIN
            error_code = 502
            excpt_cond = 'Error ' + strstr(error_code) + ' in ' + $
               rout_name + ': The inversion procedure did not converge in ' + $
               strstr(itmax) + ' iterations.'
            END
         ELSE: BEGIN
            error_code = 509
            excpt_cond = 'Error ' + strstr(error_code) + ' in ' + $
               rout_name + ': Unrecognized status code returned from ' + $
               'CURVEFIT.'
            END
      ENDCASE
      RETURN, error_code
   ENDIF

   ;  If requested, plot the model with the posterior values of the parameters
   ;  and superimpose the measurements:
   IF (plot_it) THEN BEGIN
      yp = CALL_FUNCTION(model_f, xp, params, pdsf1, pdsf2, $
         DOUBLE = double, DEBUG = debug, EXCPT_COND = excpt_cond)

      params_str = round_dec(params, 2, $
         DEBUG = debug, EXCPT_COND = excpt_cond)
      params_str = strcat(params_str, ', ', $
         DEBUG = debug, EXCPT_COND = excpt_cond)

      rc = plt_dsf(xp, pdsf1, pdsf2, yp, $
         F_TYPE = model_f, PARAMS_STR = params_str, $
         XTIME = xtime, X_DATA = x, Y_DATA = y, $
         FROM_X = from_x, TO_X = to_x, $
         FROM_Y = from_y, TO_Y = to_y, $
         ITER = iter, CHISQ = chisq, $
         PLOT_IT = plot_it, PLOT_FOLDER = plot_folder, $
         VERBOSE = verbose, DEBUG = debug, EXCPT_COND = excpt_cond)
   ENDIF

   RETURN, return_code

END
