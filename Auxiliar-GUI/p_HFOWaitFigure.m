% p_HFOWaitFigure

function st_output = p_HFOWaitFigure(st_intput,pstr_Field,pFieldValue)

if nargin ~= 0 
    if nargin == 3
    f_WriteFields(st_intput,pstr_Field,pFieldValue)
    else
        error('p_HFOWaitFigure:argChk','Wrong number of input arguments');
    end
    return
end

%% Variables

% Figure Background Color
v_FigColor      = [212 208 200]/255;
v_BarColor      = [0.2902 0.5294 0.1529];

st_Controls     = struct;

%% Building Figure
st_output.main      = figure(...                         
                    'MenuBar','None', ...
                    'ToolBar','None', ...
                    'NumberTitle','off', ...
                    'Name','Running HFO Detection', ...
                    'Color',v_FigColor,...
                    'Units','normalized',...
                    'Position',[.3 .4 .4 .5]);
                
%% Building Controls                
st_Controls.FileAxes    = axes(...
                        'Parent',st_output.main,...
                        'Box','on',...
                        'XLim',[0 1],...
                        'YLim',[0 1],...
                        'XTick',[],...
                        'XTickLabel',[],...
                        'YTick',[],...
                        'YTickLabel',[],...
                        'Units','normalized',...
                        'Position',[.1 .15 .8 .04]);        
                
st_Controls.ChAxes      = axes(...
                        'Parent',st_output.main,...
                        'Box','on',...
                        'XLim',[0 1],...
                        'YLim',[0 1],...
                        'XTick',[],...
                        'XTickLabel',[],...
                        'YTick',[],...
                        'YTickLabel',[],...
                        'Units','normalized',...
                        'Position',[.1 .25 .8 .04]); 
                
st_Controls.MethAxes    = axes(...
                        'Parent',st_output.main,...
                        'Box','on',...
                        'XLim',[0 1],...
                        'YLim',[0 1],...
                        'XTick',[],...
                        'XTickLabel',[],...
                        'YTick',[],...
                        'YTickLabel',[],...
                        'Units','normalized',...
                        'Position',[.1 .35 .8 .04]);    
                
st_Controls.LogLabel  = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','text', ...
                        'BackgroundColor',v_FigColor,...
                        'HorizontalAlignment','left',...
                        'String','Logs',...
                        'Units','normalized',...
                        'Position',[.1 .9 .2 .04]);                         
                    
%% Building Output     

                            
st_output.SaveButt      = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','pushbutton', ...
                        'BackgroundColor',v_FigColor,...                    
                        'HorizontalAlignment','center',...
                        'String','Save Logs',...
                        'Units','normalized',...
                        'Enable','off',...
                        'Position',[.5 .04 .2 .075],...
                        'Callback',@f_SaveLogs);
                
st_output.CloseButt     = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','pushbutton', ...
                        'BackgroundColor',v_FigColor,...                    
                        'HorizontalAlignment','center',...
                        'String','Close',...
                        'Units','normalized',...
                        'Enable','off',...
                        'Position',[.7 .04 .2 .075],...
                        'CallBack','close');       
                    
st_output.LogsList      = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','list', ...
                        'BackgroundColor','w',...                    
                        'HorizontalAlignment','left',...
                        'Max',2,'Min',0,...
                        'String',{},...
                        'Units','normalized',...
                        'Position',[.1 .5 .8 .4]);

st_output.MethString    = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','text', ...
                        'BackgroundColor',v_FigColor,...
                        'HorizontalAlignment','left',...
                        'String',' ',...
                        'Units','normalized',...
                        'Position',[.1 .4 .5 .04]);
                    
st_output.ChanString    = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','text', ...
                        'BackgroundColor',v_FigColor,...
                        'HorizontalAlignment','left',...
                        'String',' ',...
                        'Units','normalized',...
                        'Position',[.1 .3 .5 .04]);
                    
st_output.FileString    = uicontrol(...
                        'Parent', st_output.main,...
                        'Style','text', ...
                        'BackgroundColor',v_FigColor,...
                        'HorizontalAlignment','left',...
                        'String',' ',...
                        'Units','normalized',...
                        'Position',[.1 .2 .5 .04]);            

st_output.MethPatch     = patch(...
                        'Parent',st_Controls.MethAxes,...
                        'XData',[0 0 0 0],...
                        'YData',[0 1 1 0],...
                        'FaceColor',v_BarColor,...
                        'EdgeColor','none');
                    
st_output.ChanPatch     = patch(...
                        'Parent',st_Controls.ChAxes,...
                        'XData',[0 0 0 0],...
                        'YData',[-1 1 1 -1],...
                        'FaceColor',v_BarColor,...
                        'EdgeColor','none');
                    
st_output.FilePatch     = patch(...
                        'Parent',st_Controls.FileAxes,...
                        'XData',[0 0 0 0],...
                        'YData',[0 1 1 0],...
                        'FaceColor',v_BarColor,...
                        'EdgeColor','none');
                    
%% Functions
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    function f_SaveLogs(~,~)
        
        [str_FileName,str_PathName] = uiputfile('rlog','Save Log File',...
                                    'HFO_LogFile.rlog');
        
        if ~ischar(str_FileName)
            return
        end
                                
        str_Path    = fullfile(str_PathName,str_FileName);
        str_Logs    = (get(st_output.LogsList,'String'));
        s_fid       = fopen(str_Path, 'wt');
        
        for kk = 1:size(str_Logs,1)
            fprintf(s_fid, '%s\n', cell2mat(str_Logs(kk)));
        end
        
        fclose(s_fid);
    end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    function f_WriteFields(st_intput,pstr_Field,pFieldValue)
        
        if ~isfield(st_intput,pstr_Field)
            
            error('p_HFOWaitFigure:FalseField','False field of structure');
        end
        
        s_InputField    = getfield(st_intput,pstr_Field); %#ok<GFLD>
        
        figure(st_intput.main)

%         uicontrol(st_intput.LogsList);
        switch s_InputField
            
            case st_intput.LogsList
                
                if ~isempty(pFieldValue)
                    str_string          = get(st_intput.LogsList,'String');
                    str_string{end+1}   = pFieldValue;
                    set(st_intput.LogsList,...
                        'String',str_string,...
                        'value',numel(str_string))
                else
                    set(st_intput.LogsList,...
                        'String',{})
                end
                
            case st_intput.MethString
                set(st_intput.MethString,'String',pFieldValue)      
                
            case st_intput.ChanString
                set(st_intput.ChanString,'String',pFieldValue)
                
            case st_intput.FileString
                set(st_intput.FileString,'String',pFieldValue)
                
            case st_intput.MethPatch
                pFieldValue     = [0 0 pFieldValue pFieldValue];
                set(st_intput.MethPatch,'XData',pFieldValue)
                
            case st_intput.ChanPatch
                pFieldValue     = [0 0 pFieldValue pFieldValue];
                set(st_intput.ChanPatch,'XData',pFieldValue)
                
            case st_intput.FilePatch
                pFieldValue     = [0 0 pFieldValue pFieldValue];
                set(st_intput.FilePatch,'XData',pFieldValue)
            
            case st_intput.SaveButt  
                
                if pFieldValue
                    set(st_intput.SaveButt,'Enable','on')
                else
                    set(st_intput.SaveButt,'Enable','off')
                end
            
            case st_intput.CloseButt
            
                if pFieldValue
                    set(st_intput.CloseButt,'Enable','on')
                else
                    set(st_intput.CloseButt,'Enable','off')
                end
                
                
            otherwise
        end
        pause(0.001)
    end
end