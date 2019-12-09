FUNCTION plt_dsf, $
   x, $
   fsf_y, $
   ssf_y, $
   dsf_y, $
   F_TYPE = f_type, $
   PARAMS_STR = params_str, $
   XTIME = xtime, $
   X_DATA = x_data, $
   Y_DATA = y_data, $
   FROM_X = from_x, $
   TO_X = to_x, $
   FROM_Y = from_y, $
   TO_Y = to_y, $
   ITER = iter, $
   CHISQ = chisq, $
   PLOT_IT = plot_it, $
   PLOT_FOLDER = plot_folder, $
   VERBOSE = verbose, $
   DEBUG = debug, $
   EXCPT_COND = excpt_cond

   ;Sec-Doc
   ;  PURPOSE: This function plots the two components as well as the
   ;  combined value of an arbitrary double S-shaped function defined by
   ;  its (typically 7) parameters, and data arrays if they are also
   ;  provided.
   ;
   ;  ALGORITHM: This function plots the traces of the 3 input positional
   ;  parameters fsf_y, ssf_y and dsf_y, as a function of the input
   ;  positional parameter x, or optionally over the alternative range
   ;  [from_x, to_x]. If arrays of x and y data values are also provided,
   ;  they are superinposed on the plot.
   ;
   ;  SYNTAX: rc = plt_dsf(x, fsf_y, ssf_y, dsf_y, $
   ;  F_TYPE = f_type, PARAMS_STR = params_str, $
   ;  XTIME = xtime, X_DATA = x_data, Y_DATA = y_data, $
   ;  FROM_X = from_x, TO_X = to_x, $
   ;  FROM_Y = from_y, TO_Y = to_y, $
   ;  ITER = iter, CHISQ = chisq, $
   ;  PLOT_IT = plot_it, PLOT_FOLDER = plot_folder, $
   ;  VERBOSE = verbose, DEBUG = debug, EXCPT_COND = excpt_cond)
   ;
   ;  POSITIONAL PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   x {FLOAT array} [I]: The independent variable of the S-shaped
   ;      functions.
   ;
   ;  *   fsf_y {FLOAT array} [I]: The values of the first S-shaped
   ;      function for the corresponding values of x.
   ;
   ;  *   ssf_y {FLOAT array} [I]: The values of the second S-shaped
   ;      function for the corresponding values of x.
   ;
   ;  *   dsf_y {FLOAT array} [I]: The values of the double S-shaped
   ;      function for the corresponding values of x.
   ;
   ;  KEYWORD PARAMETERS [INPUT/OUTPUT]:
   ;
   ;  *   F_TYPE = f_type {STRING} [I]: The optional abbreviated name
   ;      (acronym) of the double S-shaped function, used to generate the
   ;      ordinate axis and overall titles of the plot.
   ;
   ;  *   PARAMS_STR = params_str {STRING} [I]: The optional string
   ;      containing the numerical values of the function parameters, used
   ;      to generate the overall title of the plot.
   ;
   ;  *   XTIME = xtime {INT} [I] (Default value: 0): Flag to enable (> 0)
   ;      or skip (0) interpreting the values of the input positional
   ;      parameter x as Julian dates.
   ;
   ;  *   X_DATA = x_data {FLOAT} [I] (Default value: None): The optional
   ;      abscissas of the data points.
   ;
   ;  *   Y_DATA = y_data {FLOAT} [I] (Default value: None): The optional
   ;      ordinates of the data points.
   ;
   ;  *   FROM_X = from_x {FLOAT} [I] (Default value: MIN(x): The optional
   ;      smallest value of x to be plotted.
   ;
   ;  *   TO_X = to_x {FLOAT} [I] (Default value: MAX(x): The optional
   ;      largest value of x to be plotted.
   ;
   ;  *   FROM_Y = from_y {FLOAT} [I] (Default value: MIN(y): The optional
   ;      smallest value of y to be plotted.
   ;
   ;  *   TO_Y = to_y {FLOAT} [I] (Default value: MAX(y): The optional
   ;      largest value of y to be plotted.
   ;
   ;  *   ITER = iter {INT} [I] (Default value: 0): The number of
   ;      iterations accomplished when inverting the model against the
   ;      data. A negative value of iter is interpreted as requiring to
   ;      plot the prior situation, i.e., before the model inversion takes
   ;      place.
   ;
   ;  *   CHISQ = chisq {FLOAT} [I] (Default value: None): The χ² value
   ;      expressing the degree of fitness between the model and the data.
   ;
   ;  *   PLOT_IT = plot_it{INT} [I] (Default value: 0): Flag to activate
   ;      (1) or skip (0) generating plots.
   ;
   ;  *   PLOT_FOLDER = plot_folder {STRING} [I]: The directory address of
   ;      the output folder containing the plots, if different from the
   ;      value implied by the default set by function set_roots_vers.pro)
   ;      and the routine arguments.
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
   ;  RETURNED VALUE TYPE: INT [or N/A].
   ;
   ;  OUTCOME:
   ;
   ;  *   If no exception condition has been detected, this function
   ;      returns 0, and the output keyword parameter excpt_cond is set to
   ;      a null string, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided in the call. If the optional input keyword parameter
   ;      PLOT_IT is set, a plot is generated in the specified or default
   ;      folder.
   ;
   ;  *   If an exception condition has been detected, this function
   ;      returns a non-zero error code, and the output keyword parameter
   ;      excpt_cond contains a message about the exception condition
   ;      encountered, if the optional input keyword parameter DEBUG is
   ;      set and if the optional output keyword parameter EXCPT_COND is
   ;      provided. If the optional input keyword parameter PLOT_IT is
   ;      set, the plot may not have been created.
   ;
   ;  EXCEPTION CONDITIONS:
   ;
   ;  *   Error 100: One or more positional parameter(s) are missing.
   ;
   ;  *   Error 110: The input positional parameter x is not a numeric
   ;      array.
   ;
   ;  *   Error 120: The input positional parameter fsf_y is not a numeric
   ;      array.
   ;
   ;  *   Error 130: The input positional parameter ssf_y is not a numeric
   ;      array.
   ;
   ;  *   Error 140: The input positional parameter dsf_y is not a numeric
   ;      array.
   ;
   ;  *   Error 150: The input positional parameters x, fsf_y, ssf_y and
   ;      dsf_y do not contain the same numbers of elements.
   ;
   ;  *   Error 199: An exception condition occurred in
   ;      set_roots_vers.pro.
   ;
   ;  *   Error 400: The directory plot_fpath is unwritable.
   ;
   ;  DEPENDENCIES:
   ;
   ;  *   force_path_sep.pro
   ;
   ;  *   is_array.pro
   ;
   ;  *   is_numeric.pro
   ;
   ;  *   is_writable_dir.pro
   ;
   ;  *   set_roots_vers.pro
   ;
   ;  *   set_value_range.pro
   ;
   ;  *   strstr.pro
   ;
   ;  *   today.pro
   ;
   ;  REMARKS:
   ;
   ;  *   NOTE 1: This IDL function plots the input data sets and saves
   ;      the resulting exhibit in a file only if the input keyword
   ;      parameter PLOT_IT is set.
   ;
   ;  EXAMPLES:
   ;
   ;      See the diagrams following the descriptions of functions
   ;      pd_gaus_f.pro, pd_hytg_f.pro, pd_logi_f.pro and pd_sine_f.pro.
   ;
   ;  REFERENCES:
   ;
   ;  *   Michel M. Verstraete (2019) _User Manual for the Phenology
   ;      package_.
   ;
   ;  VERSIONING:
   ;
   ;  *   2019–10–05: Version 1.0 — Initial release.
   ;
   ;  *   2019–10–31: Version 2.0.0 — Adopt revised coding and
   ;      documentation standards, and switch to 3-parts version
   ;      identifiers; initial public release.
   ;
   ;  *   2019–11–18: Version 2.0.1 — Update the text annotations to the
   ;      plots and add the reference to the _User Manual_.
   ;
   ;  *   2019–11–26: Version 2.0.2 — Update the handling of the iter
   ;      keyword parameter, correct a spelling mistake in the output
   ;      plot, and update the documentation.
   ;
   ;  *   2019–12–06: Version 2.0.3 — Update the code to generate plots
   ;      showing days, months and years (rather than Julian days) when
   ;      the x axis is time.
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
   IF (KEYWORD_SET(xtime)) THEN xtime = 1 ELSE xtime = 0
   IF (KEYWORD_SET(plot_it)) THEN plot_it = 1 ELSE plot_it = 0
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
            ' positional parameter(s): x, fsf_y, ssf_y, dsf_y.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'x' is not a numeric array:
      IF ((is_numeric(x) NE 1) OR (is_array(x) NE 1)) THEN BEGIN
         error_code = 110
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter x is not a numeric array.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'fsf_y' is not a numeric array:
      IF ((is_numeric(fsf_y) NE 1) OR (is_array(fsf_y) NE 1)) THEN BEGIN
         error_code = 120
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter fsf_y is not a numeric array.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'ssf_y' is not a numeric array:
      IF ((is_numeric(ssf_y) NE 1) OR (is_array(ssf_y) NE 1)) THEN BEGIN
         error_code = 130
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter ssf_y is not a numeric array.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameter 'dsf_y' is not a numeric array:
      IF ((is_numeric(dsf_y) NE 1) OR (is_array(dsf_y) NE 1)) THEN BEGIN
         error_code = 140
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameter dsf_y is not a numeric array.'
         RETURN, error_code
      ENDIF

   ;  Return to the calling routine with an error message if the input
   ;  positional parameters x, fsf_y, ssf_y and dsf_y do not contain the same
   ;  number of elements:
      IF ((N_ELEMENTS(x) NE N_ELEMENTS(fsf_y)) OR $
         (N_ELEMENTS(x) NE N_ELEMENTS(ssf_y)) OR $
         (N_ELEMENTS(x) NE N_ELEMENTS(dsf_y))) THEN BEGIN
         error_code = 150
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + rout_name + $
            ': The input positional parameters x, fsf_y, ssf_y and dsf_y ' + $
            'do not contain the same numbers of elements.'
         RETURN, error_code
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

   ;  Set the MISR and MISR-HR version numbers if they have not been specified
   ;  explicitly:
   IF (~KEYWORD_SET(from_x)) THEN from_x = MIN(x)
   IF (~KEYWORD_SET(to_x)) THEN to_x = MAX(x)
   IF (~KEYWORD_SET(iter)) THEN iter = 0

   ;  Get today's date:
   date = today(FMT = 'ymd')

   ;  Get today's date and time:
   date_time = today(FMT = 'nice')

   IF (plot_it) THEN BEGIN

   ;  Set the directory address of the folder containing the plot files:
      IF (KEYWORD_SET(plot_folder)) THEN BEGIN
         plot_fpath = plot_folder
      ENDIF ELSE BEGIN
         plot_fpath = root_dirs[3] + 'Phenology'
      ENDELSE
      rc = force_path_sep(plot_fpath, DEBUG = debug, $
         EXCPT_COND = excpt_cond)

   ;  Create the plot directory 'plot_fpath' if it does not exist, and
   ;  return to the calling routine with an error message if it is unwritable:
      res = is_writable_dir(plot_fpath, /CREATE)
      IF (debug AND (res NE 1)) THEN BEGIN
         error_code = 400
         excpt_cond = 'Error ' + strstr(error_code) + ' in ' + $
            rout_name + ': The directory plot_fpath is unwritable.'
         RETURN, error_code
      ENDIF

   ;  Generate the specification of the plot file:
      IF (KEYWORD_SET(f_type)) THEN BEGIN
         f_str = '_' + f_type
      ENDIF ELSE BEGIN
         f_str = ''
      ENDELSE
      IF (iter LT 0) THEN f_str = f_str + '_prior' ELSE f_str = f_str + '_post'
      IF (KEYWORD_SET(params_str)) THEN BEGIN
         c_str = '_' + params_str.Replace(', ', '_')
      ENDIF ELSE BEGIN
         c_str = ''
      ENDELSE
      plot_fname = 'Plot_dsf' + f_str + c_str + '_' + date + '.png'
      plot_fspec = plot_fpath + plot_fname

   ;  Set the range of 'y' over which the function values should be plotted:
      min_val = MIN([fsf_y, ssf_y, dsf_y])
      IF (KEYWORD_SET(y_data)) THEN min_val = MIN([min_val, MIN(y_data)])
      max_val = MAX([fsf_y, ssf_y, dsf_y])
      IF (KEYWORD_SET(y_data)) THEN max_val = MAX([max_val, MAX(y_data)])
      res = set_value_range(ROUND(min_val) - 1, ROUND(max_val) + 1, $
         DEBUG = debug, EXCPT_COND = excpt_cond)
      IF (~KEYWORD_SET(from_y)) THEN from_y = res[0]
      IF (~KEYWORD_SET(to_y)) THEN to_y = res[1]
      range_y = [from_y, to_y]

   ;  Plot the first component:
      IF (xtime) THEN BEGIN
         xtu = ['Days', 'Months', 'Years']
         xti = 'Time'
      ENDIF ELSE BEGIN
         xtu = ''
         xti = 'x'
      ENDELSE
      p_1 = PLOT( $
         x, $
         fsf_y, $
         DIMENSION = [650, 600], $
         POSITION = [0.15, 0.25, 0.9, 0.9], $
         XRANGE = [from_x, to_x], $
         XTICKUNITS = xtu, $
         XTITLE = xti, $
         YRANGE = range_y, $
         YTITLE = f_type, $
         YSTYLE = 1, $
         COLOR = 'Green')

   ;  Plot the second component:
      p_2 = PLOT( $
         x, $
         ssf_y, $
         XRANGE = [from_x, to_x], $
         COLOR = 'Blue', $
         /OVERPLOT)

   ;  Plot the double S-shaped function:
      p_3 = PLOT( $
         x, $
         dsf_y, $
         XRANGE = [from_x, to_x], $
         COLOR = 'Red', $
         TITLE = f_type + ' (' + params_str + ')', $
         /OVERPLOT)

   ;  Add the legend:
      x_t1 = from_x + 0.05 * (to_x - from_x)
      x_t2 = x_t1 + 0.1 * (to_x - from_x)
      y_t1 = range_y[0] + 0.05 * (range_y[1] - range_y[0])
      p_4 = PLOT( $
         [x_t1, x_t2], $
         [y_t1, y_t1], $
         COLOR = 'Red', $
         /OVERPLOT)
      x_t3 = x_t2 + 0.05 * (to_x - from_x)
      t_1 = TEXT(x_t3, y_t1, 'Double S function', /DATA, FONT_SIZE = 7)

      y_t2 = y_t1 + 0.05 * (range_y[1] - range_y[0])
      p_5 = PLOT( $
         [x_t1, x_t2], $
         [y_t2, y_t2], $
         COLOR = 'Blue', $
         /OVERPLOT)
      t_2 = TEXT(x_t3, y_t2, 'Second S function', /DATA, FONT_SIZE = 7)

      y_t3 = y_t2 + 0.05 * (range_y[1] - range_y[0])
      p_6 = PLOT( $
         [x_t1, x_t2], $
         [y_t3, y_t3], $
         COLOR = 'Green', $
         /OVERPLOT)
      t_3 = TEXT(x_t3, y_t3, 'First S function', /DATA, FONT_SIZE = 7)

   ;  If data points are also provided, overplot them:
      IF (KEYWORD_SET(x_data) AND KEYWORD_SET(y_data)) THEN BEGIN
         n_pts = N_ELEMENTS(x_data)
         d1 = PLOT( $
            x_data, $
            y_data, $
            SYMBOL = "*", $
            LINESTYLE = 'none', $
            /OVERPLOT)

   ;  Add the number of points:
         xt_4 = from_x + 0.05 * (to_x - from_x)
         yt_4 = range_y[0] + 0.85 * (range_y[1] - range_y[0])
         t_4 = TEXT(xt_4, yt_4, '# points: ' + strstr(n_pts), $
            /DATA, FONT_SIZE = 7)

   ;  Add the number of iterations:
         IF (iter GE 0) THEN BEGIN
            xt_5 = from_x + 0.05 * (to_x - from_x)
            yt_5 = range_y[0] + 0.90 * (range_y[1] - range_y[0])
            IF (iter GE 0) THEN BEGIN
               t_5 = TEXT(xt_5, yt_5, '# iterations: ' + strstr(iter), $
                  /DATA, FONT_SIZE = 7)
            ENDIF ELSE BEGIN
               t_5 = TEXT(xt_5, yt_5, 'Prior configuration.', $
                  /DATA, FONT_SIZE = 7)
            ENDELSE
         ENDIF

   ;  Add the Chi square value:
         IF (KEYWORD_SET(chisq)) THEN BEGIN
            xt_6 = from_x + 0.95 * (to_x - from_x)
            yt_6 = range_y[0] + 0.90 * (range_y[1] - range_y[0])
            t_6 = TEXT(xt_6, yt_6, '$\chi^2$: ' + round_dec(chisq, 3), $
               /DATA, ALIGNMENT = 1.0, FONT_SIZE = 7)
         ENDIF
      ENDIF

   ;  Save the plot:
      p_1.Save, plot_fspec
   ENDIF

   IF ((verbose GT 0) AND (plot_it)) THEN BEGIN
      PRINT, 'The plot file has been saved in ' + plot_fspec + '.'
   ENDIF
   IF (verbose GT 1) THEN PRINT, 'Exiting ' + rout_name + '.'

   RETURN, return_code

END
