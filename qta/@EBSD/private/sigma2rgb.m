function c = sigma2rgb(S3G,varargin)
% converts orientations to rgb values

% get reference orientation
q0 = get_option(varargin,'center',idquaternion);
S3G = S3G * inverse(q0);

% restrict to fundamental region
q = quaternion(getFundamentalRegion(S3G));

% convert to sigma angles
[phi1,Phi,phi2] = quat2euler(q,'Bunge');
[maxphi1,maxPhi,maxphi2] = getFundamentalRegion(getCSym(S3G),getSSym(S3G));
s1 = mod(phi2-phi1,maxphi1) ./ maxphi1;
Phi = mod(-Phi,maxPhi); Phi = Phi./max(Phi(:));
s2 = mod(phi1+phi2,maxphi2)./ maxphi2;

c = [s1(:),Phi(:),s2(:)];