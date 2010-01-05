function d = dot_outer_noabs(g1,g2)
% outer inner product between two quaternions
%% Input
%  g1, g2 - @quaternion
%% Output
%  d - double
%
%% formuala:
% cos angle(g1,g2)/2 = dout(g1,g2)

if ~isempty(g1) && ~isempty(g2)

	d = g1.a(:) * g2.a(:).' + g1.b(:) * g2.b(:).' + ...
		g1.c(:) * g2.c(:).' + g1.d(:) * g2.d(:).';

	d = reshape(d,[numel(g1),numel(g2)]);
	
else
		d = [];
end