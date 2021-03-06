classdef patalaOrientationMapping < orientationMapping
% converts misorientations to rgb values as described in 
%
% S. Patala, J. K. Mason, and C. A. Schuh, Improved representations of
% misorientation information for grain boundary science and engineering,
% Prog. Mater. Sci., vol. 57, no. 8, pp. 1383-1425, 2012.
  
  properties
    
  end
  
  methods
   
    function oM = patalaOrientationMapping(varargin)
      oM = oM@orientationMapping(varargin{:});
    end
    
    function rgb = orientation2color(oM,mori) 

      q = quaternion(mori.project2FundamentalRegion('antipodal'));

      v = Rodrigues(rotation('axis',q.axis,'angle',q.angle));

      % this is to adjust to the "correct" fundamental sector
      v = rotate(v,-oM.CS1.bAxis.rho);
      
      switch oM.CS1.LaueName
        case 'm-3m'
          rgb = colormap432(v);
        case 'mmm'
          rgb = colormap222(v);
        case {'m-3'}
          rgb = colormap23(v);
        case {'4/mmm'}
          rgb = colormap422(v);
        case {'6/mmm'}
          rgb = colormap622(v);       
        otherwise
          error('For symmetry %s patala colorcoding is not defined.',...
            cs.pointGroup)
      end
      rgb = reshape(rgb,[size(mori) 3]);
    end
  end
end


% Copyright 2013 Oliver Johnson, Srikanth Patala
% 
% This file is part of MisorientationMaps.
% 
%     MisorientationMaps is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     MisorientationMaps is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MisorientationMaps.  If not, see <http://www.gnu.org/licenses/>.

