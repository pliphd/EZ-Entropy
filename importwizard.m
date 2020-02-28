% Import Wizard
% 
% Descriptions tba
% 
%   $Author:  Peng Li, Ph.D.
%                   School of Control Science and Engineering, Shandong University
%                   Division of Sleep Medicine, Brigham & Women's Hospital
%                   Division of Sleep Medicine, Harvard Medical School
%   $Date:    May 16, 2018
% 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                      (C) Peng Li 2018 -
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 
classdef importwizard < handle
    properties (Access = private)
        Panel
        showlistEdit
        chooselistButton
        fileList
        
        Tabgroup
        segTab
        segCheckbox
        segEdit
        segText
        gapTab
        gapCheckbox
        gapEdit
        gapText
        
        datapathEdit
        datapathButton
        importButton
        
        segSuffix = '.seg'
        gapSuffix = '.gap'
    end
    
    properties (Access = public)
        wizardFigure
        imported = 0
        
        DataPath
        FileList
        SegList
        GapList
    end
    
    methods (Access = public)
        function app = importwizard
            createComponents(app);
        end
    end
    
    methods (Access = private)
        function createComponents(app)
            Pos = CenterFig(534, 300, 'pixels');
            app.wizardFigure = uifigure('Color', 'w', 'Units', 'pixels', 'Position', Pos, ...
                'Name', 'Data import wizard', ...
                'NumberTitle', 'off', 'Resize', 'off');
            app.Panel = uipanel(app.wizardFigure, 'Position', [8 8 520 286], ...
                'BackgroundColor', 'w');
            
            % define file list
            app.showlistEdit = uieditfield(app.Panel, 'text', ...
                'Position', [40 250 475 20], 'HorizontalAlignment', 'left', ...
                'Value', 'Choose a list file ...');
            app.chooselistButton = uibutton(app.Panel, ...
                'Position', [5 250 30 20], 'Text', '...', 'ButtonPushedFcn', @(source, event) ListButtonCallback(app, source, event));
            
            % list file names
            app.fileList = uilistbox(app.Panel, 'Position', [5 5 250 234], 'Items', {}, 'Value', {});
            
            % seg and gap options
            app.Tabgroup = uitabgroup(app.Panel, 'Position', [260 150 255 89]);
            
            app.segTab   = uitab(app.Tabgroup, 'Title', 'segments', 'BackgroundColor', 'w');
            app.segCheckbox = uicheckbox(app.segTab, ...
                'Position', [10 35 80 15], 'Text', 'Allow', ...
                'ValueChangedFcn', @(source, event) SegCheckboxCallback(app, source, event));
            app.segEdit = uieditfield(app.segTab, ...
                'Position', [90 10 155 20], 'HorizontalAlignment', 'left', 'Enable', 'off', 'Value', '.seg', 'ValueChangedFcn', @(source, event) SegEditCallback(app, source, event));
            app.segText = uilabel(app.segTab, ...
                'Position', [20 10 65 20], 'Text', 'seg suffix:', 'HorizontalAlignment', 'right', 'Enable', 'off', 'BackgroundColor', 'w');
            
            app.gapTab   = uitab(app.Tabgroup, 'Title', 'gaps', 'BackgroundColor', 'w');
            app.gapCheckbox = uicheckbox(app.gapTab, ...
                'Position', [10 35 80 15], 'Text', 'Allow', ...
                'ValueChangedFcn', @(source, event) GapCheckboxCallback(app, source, event));
            app.gapEdit = uieditfield(app.gapTab, ...
                'Position', [90 10 155 20], 'HorizontalAlignment', 'left', 'Enable', 'off', 'Value', '.gap', 'ValueChangedFcn', @(source, event) GapEditCallback(app, source, event));
            app.gapText = uilabel(app.gapTab, ...
                'Position', [20 10 65 20], 'Text', 'gap suffix:', 'HorizontalAlignment', 'right', 'Enable', 'off', 'BackgroundColor', 'w');
            
            % data path
            app.datapathEdit = uieditfield(app.Panel, ...
                'Position', [350 114 165 20], 'HorizontalAlignment', 'left');
            app.datapathButton = uibutton(app.Panel, 'Text', 'Data folder', ...
                'Position', [260 114 80 20], 'ButtonPushedFcn', @(source, event) DatapathButtonCallback(app, source, event));
            
            % confirm
            app.importButton = uibutton(app.Panel, 'Text', 'Import', ...
                'Position', [465 5 50 20], 'ButtonPushedFcn', @(source, event) ImportButtonCallback(app, source, event));
        end
    end
    
    methods (Access = private)
        function app = ListButtonCallback(app, source, event)
            [filename, pathname] = uigetfile('*.txt', 'Choose a file that lists data records ...');
            
            if filename == 0
                return;
            end
            
            listpath = fullfile(pathname, filename);
            app.showlistEdit.Value = listpath;
            
            fid     = fopen(listpath, 'r');
            allList = textscan(fid, '%s');
            fclose(fid);
            
            app.FileList = allList{1};
            app.fileList.Items = app.FileList;
        end
        
        function app = SegCheckboxCallback(app, source, event)
            if app.segCheckbox.Value == 1
                app.segEdit.Enable = 'on';
                app.segText.Enable = 'on';
            else
                app.segEdit.Enable = 'off';
                app.segText.Enable = 'off';
            end
        end
        
        function app = GapCheckboxCallback(app, source, event)
            if app.gapCheckbox.Value == 1
                app.gapEdit.Enable = 'on';
                app.gapText.Enable = 'on';
            else
                app.gapEdit.Enable = 'off';
                app.gapText.Enable = 'off';
            end
        end
        
        function app = DatapathButtonCallback(app, source, event)
            app.DataPath = uigetdir('.', 'Choos a folder that contains all data recordings ...');
            if app.DataPath == 0
                return;
            end
            app.datapathEdit.Value = app.DataPath;
        end
        
        function app = SegEditCallback(app, source, event)
            app.segSuffix = source.Value;
        end
        
        function app = GapEditCallback(app, source, event)
            app.gapSuffix = source.Value;
        end
        
        function app = ImportButtonCallback(app, source, event)
            if ~isempty(app.fileList.Items) && ~isempty(app.datapathEdit.Value)
                app.imported = 1;
                if app.segCheckbox.Value == 1
                    app.SegList = cellfun(@(x) [x(1:end-4) app.segSuffix], app.FileList, 'UniformOutput', 0);
                else
                    app.SegList = repmat({''}, length(app.FileList), 1);
                end
                if app.gapCheckbox.Value == 1
                    app.GapList = cellfun(@(x) [x(1:end-4) app.gapSuffix], app.FileList, 'UniformOutput', 0);
                else
                    app.GapList = repmat({''}, length(app.FileList), 1);
                end
            end
            closereq;
        end
    end
end