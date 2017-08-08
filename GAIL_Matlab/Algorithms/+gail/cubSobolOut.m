classdef cubSobolOut < gail.cubSobolParam & gail.outParam
   %GAIL.cubSobolOut is a class containing the parameters related to the
   %outputs from the cubBayesLattice algorithm that computes integrals.
   %   This class includes the approximation to the integral
   %
   % Example 1.
   % >> cubSobolParamObj = gail.cubSobolParam; %an input object
   % >> cubSobolParamObj = gail.cubSobolOut(cubSobolParamObj); %copied to becom an output object
   % >> cubSobolParamObj.sol = 1.467; %integral value is recorded
   % >> cubSobolParamObj.nSample = 31415926; %sample size is recorded
   % >> cubSobolParamObj.time = 0.0278 %time of computation is recorded
   % cubSobolParamObj =
   %   cubSobolOut with properties:
   %
   %              f: @(x)sum(x.^2,2)
   %         domain: [2�1 double]
   %        measure: 'uniform'
   %         absTol: 0.010000000000000
   %         relTol: 0
   %             mu: 1.467000000000000
   %        nSample: 31415926
   %           time: 0.027800000000000
   %
   %
   % Author: Fred J. Hickernell
   
   properties
%       mu %approximation to the mean
   end
   
   properties (Hidden, SetAccess = private)
   end
   
   methods
      
      % Creating a cubOut process
      function obj = cubSobolOut(val)
         %this constructor essentially parses inputs
         %the parser will look for a cubSobolOut object
         obj@gail.cubSobolParam(val)
      end %of constructor
      
%       function set.sol(obj,val)
%          validateattributes(val, {'numeric'}, {'scalar'})
%          obj.sol = val;
%       end
      
   end
   
   methods (Access = protected)
      
      function propList = getPropertyList(obj)
         propList = getPropertyList@gail.cubSobolParam(obj);
         propList.sol = obj.sol;
         propList.nSample = obj.nSample;
         propList.time = obj.time;
         propList.errBd = obj.errBd;
         propList.tolVal = obj.tolVal;
         propList.measure=obj.measure;
         propList.measureType=obj.measureType;
         
         disp(obj.nSample);
      end
   end
   
end
