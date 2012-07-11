%% Antipodal Symmetry
% Explains the MTEX option antipodal and the impact of antipodal symmetry
% to pole figure plots and EBSD colorcoding. 
%
%% Open in Editor
%
%% Contents
%
%% Directions vs. Axes
%
% In MTEX it is possible to consider three dimensional vectors either as
% directions or as axes. The key option to distinguish between both
% interpretations is *antipodal*.
%
% By default the pair of vectors

v1 = vector3d(1,1,2);
v2 = vector3d(1,1,-2);

%%
% when plotted at the sphere

close all; figure('position',[100 100 400 300])
plot([v1,v2],'label',{'v_1','v_2'})

%%
% these vectors will appear either on the upper or on the lower hemisphere. In order to treat
% these vectors as axes, i.e. in order to assume antipodal symmetry - one
% has to use the keyword *antipodal*.

plot([v1,v2],'label',{'v_1','v_2'},'antipodal')

%%
% Now the direction v_2 is identified with the direction -v_2 which
% plots at the upper hemisphere.

%% The Angle between Directions and Axes
%
% Another example, where it matters whether antipodal symmetry is assumed
% or not is the angle between two vectors. In the absence of antipodal
% geometry we have

angle(v1,v2) / degree

%%
% whereas, if antipodal symmetry is assumed we obtain

angle(v1,v2,'antipodal') / degree

%% Antipodal Symmetry in Experimental Pole Figures
%
% Due to Friedel's law experimental pole figures always provide antipodal symmetry. One
% consequence of this fact is that MTEX plots pole figure data always on
% the upper hemisphere

mtexdata dubna

% plot pole figure data
plot(pf(1))

%%
% Moreover if you annotate a certain direction to pole figure data, it is
% always interpreted as an axis, i.e. projected to the upper hemisphere if
% necessary

annotate(vector3d(1,0,-1),'labeled')

%% Antipodal Symmetry in Recalculated Pole Figures
%
% However, in the case of pole figures calculated from an ODF antipodal
% symmetry is in general not present.

% some prefered orientation
o = orientation('Euler',20*degree,30*degree,0,'ZYZ',CS);

% define an unimodal ODF
odf = unimodalODF(o);

% plot pole figures
plotpdf(odf,Miller(1,2,2),'position',[100 100 400 200])

%%
% Hence, if one wants to compare calculated pole figures with experimental
% ones, one has to add antipodal symmetry.

plotpdf(odf,Miller(1,2,2),'antipodal')

%% Antipodal Symmetry in Inverse Pole Figures
%
% The same reasoning as above holds true for inverse pole figures. If we
% look at complete, inverse pole figures they do not posses antipodal symmetry
% in general

plotipdf(odf,yvector,'position',[100 100 400 200],'complete')

%%
% However, if we add the keyword antipodal, antipodal symmetry is enforced.

plotipdf(odf,yvector,'antipodal','complete')

%%
% Notice how MTEX, automatically reduces the fundamental region of inverse
% pole figures in the case that antipodal symmetry is present.

close all
figure(1)
plotipdf(odf,yvector,'position',[100 100 400 200])


figure(2)
plotipdf(odf,yvector,'antipodal','position',[100 100 400 200])


%% EBSD Colocoding
%
% Antipodal symmetry effects also the colocoding of ebsd plots. Let's first
% import some data.

mtexdata aachen

%%
% Now we plot these data with a colorcoding according to the inverse
% (1,0,0) pole figure. Here no antipodal symmetry is present.

close all
plot(ebsd('fe'))
colorbar

%%
% Compare to the result when antipodal symmetry is introduced.

close all
plot(ebsd('fe'),'antipodal')
colorbar
