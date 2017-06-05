%% funappx_g
% 1-D guaranteed locally adaptive function approximation (or function recovery) on [a,b]
%% Syntax
% fappx = *funappx_g*(f)
%
% fappx = *funappx_g*(f,a,b,abstol)
%
% fappx = *funappx_g*(f,'a',a,'b',b,'abstol',abstol)
%
% fappx = *funappx_g*(f,in_param)
%
% [fappx, out_param] = *funappx_g*(f,...)
%% Description
%
% fappx = *funappx_g*(f) approximates function f on the default interval
%  [0,1] by an approximated function handle fappx within the guaranteed
%  absolute error tolerance of 1e-6. When Matlab version is higher or
%  equal to 8.3, fappx is an interpolant generated by griddedInterpolant.
%  When Matlab version is lower than 8.3, fappx is a function handle
%  generated by ppval and interp1. Input f is a function handle. The
%  statement y = f(x) should accept a vector argument x and return a
%  vector y of function values that is of the same size as x.
%
% fappx = *funappx_g*(f,a,b,abstol) for a given function f and the ordered
%  input parameters that define the finite interval [a,b], and a
%  guaranteed absolute error tolerance abstol.
%
% fappx = *funappx_g*(f,'a',a,'b',b,'abstol',abstol) approximates function
%  f on the finite interval [a,b], given a guaranteed absolute error
%  tolerance abstol. All four field-value pairs are optional and can be
%  supplied in different order.
%
% fappx = *funappx_g*(f,in_param) approximates function f on the finite
%  interval [in_param.a,in_param.b], given a guaranteed absolute error
%  tolerance in_param.abstol. If a field is not specified, the default
%  value is used.
%
% [fappx, out_param] = *funappx_g*(f,...) returns an approximated function
%  fappx and an output structure out_param.
%
% *Input Arguments*
%
% * f --- input function
%
% * in_param.a --- left end point of interval, default value is 0
%
% * in_param.b --- right end point of interval, default value is 1
%
% * in_param.abstol --- guaranteed absolute error tolerance, default
%  value is 1e-6
%
% *Optional Input Arguments*
%
% * in_param.ninit --- initial number of subintervals. Default to 20.
%
% * in_param.nmax --- when number of points hits the value, iteration
%  will stop, default value is 1e7
%
% * in_param.maxiter --- max number of iterations, default value is 1000
%
% *Output Arguments*
%
% * fappx --- approximated function handle (Note: When Matlab version is
%  higher or equal to 8.3, fappx is an interpolant generated by
%  griddedInterpolant. When Matlab version is lower than 8.3, fappx is a
%  function handle generated by ppval and interp1.)
%
% * out_param.f --- input function
%
% * out_param.a --- left end point of interval
%
% * out_param.b --- right end point of interval
%
% * out_param.abstol --- guaranteed absolute error tolerance
%
% * out_param.nmax --- when number of points hits the value, iteration
%  will stop
%
% * out_param.maxiter --- max number of iterations
%
% * out_param.ninit --- initial number of points we use for each sub
%  interval
%
% * out_param.exitflag --- this is a vector with two elements, for
%   tracking important warnings in the algorithm. The algorithm is
%   considered successful (with out_param.exitflag == [0 0]) if no other
%   flags arise warning that the results are not guaranteed. The initial 
%   value is [0 0] and the final value of this parameter is encoded as
%   follows:
%    
%                    [1 0]   If reaching overbudget. It states whether
%                    the max budget is attained without reaching the
%                    guaranteed error tolerance.
%     
%                    [0 1]   If reaching overiteration. It states whether
%                    the max iterations is attained without reaching the
%                    guaranteed error tolerance.
%
% * out_param.iter --- number of iterations
%
% * out_param.npoints --- number of points we need to reach the
%  guaranteed absolute error tolerance
%
% * out_param.errest --- an estimation of the absolute error for the
%  approximation
%
%
%% Guarantee
%
% *Plese check the details of the guarantee in Reference 1.*
%
%% Examples
% *Example 1*

f = @(x) x.^2; [fappx, out_param] = funappx_g(f)

% Approximate function x^2 with default input parameter to make the error
% less than 1e-6.
%%
% *Example 2*

[fappx, out_param] = funappx_g(@(x) x.^2,0,100,1e-7,10,1000,1e8)

% Approximate function x^2 on [0,100] with error tolerance 1e-7, cost
% budget 10000000, lower bound of initial number of points 10 and upper
% bound of initial number of points 100

%%
% *Example 3*

clear in_param; in_param.a = -20; in_param.b = 20; in_param.nlo = 10;
in_param.nhi = 100; in_param.nmax = 1e8; in_param.abstol = 1e-7; 
[fappx, out_param] = funappx_g(@(x) x.^2, in_param)

% Approximate function x^2 on [-20,20] with error tolerance 1e-7, cost
% budget 1000000, lower bound of initial number of points 10 and upper
% bound of initial number of points 100
%%
% *Example 4*

clear in_param; f = @(x) x.^2;
[fappx, out_param] = funappx_g(f,'a',-10,'b',50,'nmax',1e6,'abstol',1e-7)

% Approximate function x^2 with error tolerance 1e-7, cost budget 1000000,
% lower bound of initial number of points 10 and upper
% bound of initial number of points 100
%% See Also
%
% <html>
% <a href="http://www.mathworks.com/help/matlab/ref/interp1.html">interp1</a>
% </html>
%
% <html>
% <a href="http://www.mathworks.com/help/matlab/ref/griddedinterpolant-class.html">griddedinterpolant</a>
% </html>
%
% <html>
% <a href="help_integral_g.html">integral_g</a>
% </html>
%
% <html>
% <a href="help_meanMC_g.html">meanMC_g</a>
% </html>
%
% <html>
% <a href="help_cubMC_g.html">cubMC_g</a>
% </html>
%
% <html>
% <a href="help_funmin_g.html">funmin_g</a>
% </html>
%
% <http://gailgithub.github.io/GAIL_Dev/ GAIL_Dev> 
%
%% References
%
%  [1] Sou-Cheng T. Choi, Yuhan Ding, Fred J.Hickernell, Xin Tong, "Local
%  Adaption for Approximation and Minimization of Univariate Functions,"
%  Journal of Complexity 40, pp. 17-33, 2017.
%
%  [2] Nick Clancy, Yuhan Ding, Caleb Hamilton, Fred J. Hickernell, and
%  Yizhi Zhang, "The Cost of Deterministic, Adaptive, Automatic
%  Algorithms: Cones, Not Balls," Journal of Complexity 30, pp. 21-45,
%  2014.
%            
%  [3] Sou-Cheng T. Choi, Yuhan Ding, Fred J. Hickernell, Lan Jiang,
%  Lluis Antoni Jimenez Rugama, Xin Tong, Yizhi Zhang and Xuan Zhou,
%  GAIL: Guaranteed Automatic Integration Library (Version 2.2) [MATLAB
%  Software], 2017. Available from http://gailgithub.github.io/GAIL_Dev/
%
%  [4] Sou-Cheng T. Choi, "MINRES-QLP Pack and Reliable Reproducible
%  Research via Supportable Scientific Software," Journal of Open Research
%  Software, Volume 2, Number 1, e22, pp. 1-7, 2014.
%
%  [5] Sou-Cheng T. Choi and Fred J. Hickernell, "IIT MATH-573 Reliable
%  Mathematical Software" [Course Slides], Illinois Institute of
%  Technology, Chicago, IL, 2013. Available from
%  http://gailgithub.github.io/GAIL_Dev/ 
%
