function import_gui_finish(wzrd)
% final import wizard page

pos = get(wzrd,'Position');
h = pos(4);
w = pos(3);
ph = 270;

this_page = get_panel(w,h,ph);
handles = getappdata(wzrd,'handles');
handles.pages = [handles.pages,this_page];
setappdata(this_page,'pagename','Import Data');

set(this_page,'visible','off');
 
handles.summarytitle = uicontrol('Parent',this_page,...
  'String','Data summary:',...
  'Position',[0 ph-30 w-20 20],...
  'Style','text',...
  'HorizontalAlignment','left');

handles.preview = uicontrol(...
  'Parent',this_page,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','left',...
  'Max',2,...
  'Position',[0 ph-130 w-20 100],...
  'String',blanks(0),...
  'Style','edit');
  

handles.finish_exp = uibuttongroup('title','Import to',...
  'Parent',this_page,...
  'units','pixels','position',[0 ph-270 w-20 130]);

handles.radio_exp(1) = uicontrol(...
  'Parent',handles.finish_exp,...
  'HorizontalAlignment','left',...
  'Position',[10 ph-180 160 20 ],...
  'String',' workspace variable',...
  'Value',0,...
  'Style','radio');

handles.radio_exp(2) = uicontrol(...
  'Parent',handles.finish_exp,...
  'HorizontalAlignment','left',...
  'Position',[10 ph-205 160 20 ],...
  'String',' script (m-file)',...
  'Value',1,...
  'Style','radio');

%  'Position',[190 ph-220 w-220 18 ],...
handles.template(3) = uicontrol('Parent',this_page,...
  'String','Template',...
  'Position',[190 ph-180 w-220 18 ],...
  'Style','text',...
  'HorizontalAlignment','left');


handles.template(2) = uicontrol('Parent',this_page,...
  'String','Browse Templates',...
  'Position',[10 ph-260 140 25 ],...
  'HorizontalAlignment','left');

handles.template(1) = uicontrol(...
  'Parent',this_page,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','left',...
  'Max',200,...
  'Position',[190 ph-260 w-220 80 ],...
  'String',blanks(0),...
  'Style','listbox');


handles.workspace(1) = uicontrol(...
  'Parent',this_page,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','left',...
  'Position',[190 ph-180 w-220 22 ],...
  'String',blanks(0),...
  'Style','edit');

% handles.workspace(2) = uicontrol(...
%   'Parent',this_page,...
%   'HorizontalAlignment','left',...
%   'Position',[190 ph-220 w-220 18 ],...
%   'String','variable name',...
%   'Style','text');


setappdata(this_page,'goto_callback',@goto_callback);
setappdata(this_page,'leave_callback',@leave_callback);
setappdata(wzrd,'handles',handles);

set(handles.workspace,'visible','off')
set(handles.finish_exp,'SelectionChangeFcn',@sel_export);

%% --------------- Callbacks -------------------------------------
function sel_export(varargin)

handles = getappdata(gcbf,'handles');

val_alias = {'off','on'};
set(handles.workspace,'visible',val_alias{get(handles.radio_exp(1),'Value')+1})
set(handles.template,'visible',val_alias{get(handles.radio_exp(2),'Value')+1})

function goto_callback(varargin)

handles = getappdata(gcbf,'handles');
data = getappdata(gcbf,'data');

if isa(data,'cell')
  data= data{1};
end
str = char(data);
set(handles.preview,'String',str(:,1:min(end,80)));

set(handles.summarytitle,'String',[ 'Summary of ' class(data) ' data to be imported:']);

templates = dir( fullfile(mtex_path,'templates',[ class(data) '_*.m']) );
templates = {templates.name};
templ = regexprep(templates,[ class(data) '_(\w*).m'],'$1');
% 

default_template = ~cellfun('isempty',strfind(templ,'default'));
if any(default_template)
  dval = find(default_template);
else
  dval = 1;
end

set(handles.template(1),'String',templ);
set(handles.template(1),'Value',dval);
set(handles.template(2),'Callback',{@mtex_templates,class(data)});
setappdata(gcbf,'templates',templates);


function leave_callback(varargin)

