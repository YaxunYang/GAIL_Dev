%% Digital Option in Matlab
% An option whose payout is fixed after the underlying stock exceeds 
% the predetermined threshold or strike price. It is the type of option 
% in which the payoff can take only two possible outcomes, either 
% some fixed monetary amount or nothing at all.
% 
% There are two different types of Digital Options called _Cash_ and
% _Asset_ and both exists for calls and puts.


%% BlackSchoels model for ExactPrice
% The following formulas are from the BlackScholes model and them give the
% Exact Value for an Digital Option:
%
% \[\Phi(x)=1/\sqrt{(2\pi)}\int_{-\infty}^{x}e^{-\frac{1}{2}z^2}dz\]
% 
% and,
%
% \[ d_1=\frac{\ln(\frac{S}{K})+(r-q+\sigma^2/2)T}{\sigma\sqrt{T}} \]
% \[\quad d_2=d_1-\sigma\sqrt{T} \]
%
% Where:
%
% _S_ - initial stock price
%
% _K_ - strike price
%
% _T_ - time to maturity
%
% _q_ - dividend rate
%
% _r_ - risk-free interest rate
%
% $\sigma$ - volatility
%
% $\Phi$ - cumulative distribution function of the normal distribution
%
%% Exact Price Formulas for Digital Options
% * Cash-or-nothing call
% 
% \[C=e^{-rT}\Phi(d_2)\]
% 
% * Cash-or-nothing put
% 
% \[P=e^{-rT}\Phi(-d_2)\]
% 
% * Asset-or-nothing call
% 
% \[C=Se^{-qT}\Phi(d_1)\]
% 
% * Asset-or-nothing put
% 
% \[P=Se^{-qT}\Phi(-d_1)\]

%% Example of pricing digital option for cash
% _optPrice_ is a MATLAB(R) class that generates the prices for options
% from _IID_MC_ method. _optPrice_ uses _optPayoff_ parameters, hence _optPayoff_
% uses _assePath_ parameters and this one uses _brownianMotion_ parameters
% and so on.
%
% The first step is to create a _input_ structure saying the parameters that 
% we want to analyze.
%
% Creating the _input_ structure

%Payoff Parameters
input.payoffParam.optType = {'digital'};      %Defining the Option Type
input.payoffParam.putCallType = {'call'};     %Defining the Option Type
input.payoffParam.cashAssetType = {'cash'};   %Defining the Digital Option Type
input.payoffParam.strike = 12;                %Defining the Strike Price as $12.00

%Asset Path Parameters
input.assetParam.initPrice = 9;               %Defining the Inicial Stock Price as $9.00
input.assetParam.interest = 0.01;             %Defining Interest Rate as 1%
input.assetParam.volatility = 0.5;            %Defining the Volatility as 50%

%Option Price Parameters
input.priceParam.absTol = 0.01;               %Defining the Absolute Tolerance as 1%

%Stochastic Process
input.timeDim.timeVector = (0.25:0.25:1);     %Defining the Time as four trimesters.

%%
% _DigOption1_ is the _optPrice_ class

DigOption1 = optPrice(input)
%%
% From the above formulas, the Exact Price for _DigOption1_ is:
exactResult_DigOption1 = DigOption1.exactPrice
%%
% And now, in order to compare the price from the formulas and the price
% from the Monte Carlo method for Finance, the function _genOptPrice_ is
% called.
%
% _mcResult_DigOption1_ is the price of the option, generated by IID Monte
% Carlo.

mcResult_DigOption1 = genOptPrice(DigOption1)
%% 
% As it can be seen the _exactPrice_ for _DigOption1_ is the same value of
% the _IID_MC_ method with 0.01 as absolute tolerance. 

%% Example of pricing digital option for asset
%
% Creating the _input2_ structure

%Payoff Parameters
input2.payoffParam.optType = {'digital'};      %Defining the Option Type
input2.payoffParam.putCallType = {'call'};     %Defining the Option Type
input2.payoffParam.cashAssetType = {'asset'};  %Defining the Digital Option Type
input2.payoffParam.strike = 15;                %Defining the Strike Price as $15.00

%Asset Path Parameters
input2.assetParam.initPrice = 11;              %Defining the Inicial Stock Price as $11.00
input2.assetParam.interest = 0.01;             %Defining Interest Rate as 1%
input2.assetParam.volatility = 0.65;           %Defining the Volatility as 65%

%Option Price Parameters
input2.priceParam.absTol = 0.01;               %Defining the Absolute Tolerance as 1%

%Stochastic Process
input2.timeDim.timeVector = [1 2 3];           %Defining the Time as three years.
%%
% _tianci_ is the _optPrice_ class

DigOption2 = optPrice(input2)
%%
% From the above formulas, the Exact Price for _DigOption2_ is:
exactResult_DigOption2 = DigOption2.exactPrice
%%
% Now comparing, _mcResult_DigOption2_ is the price of the option, generated by IID Monte Carlo

mcResult_DigOption2 = genOptPrice(DigOption2)