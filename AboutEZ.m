% About
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
classdef AboutEZ < handle
    properties (Access = private)
        AboutEZFigure
        icanAxes
        logButton
        verLabel
        rightLabel
        ackLabel
    end
    
    methods (Access = public)
        function app = AboutEZ(varargin)
            createComponents(app);
            
            if nargin == 0
                icon2Read = 'EZEntropy.png';
                app.AboutEZFigure.Name = 'About EZ Entropy';
            elseif nargin >= 2
                app.AboutEZFigure.Name = varargin{1};
                icon2Read = varargin{2};
            end
            
            [im, ~, imalpha] = imread(icon2Read);
            image(im, 'Parent', app.icanAxes, 'AlphaData', imalpha);
            app.icanAxes.XLim = [1 200];
            app.icanAxes.YLim = [1 160];
            app.icanAxes.XTick = [];
            app.icanAxes.YTick = [];
            app.icanAxes.XColor = 'none';
            app.icanAxes.YColor = 'none';
            app.icanAxes.Toolbar.Visible = 'off';
            
            if nargin == 3
                app.verLabel.Text = varargin{3};
            end
        end
    end
    
    methods (Access = private)
        function createComponents(app)
            Pos = CenterFig(428, 240, 'pixels');
            app.AboutEZFigure = uifigure('Color', 'w', 'Units', 'pixels', 'Position', Pos, ...
                'Name', 'About EZ Entropy', ...
                'NumberTitle', 'off', 'Resize', 'off');
            
            app.icanAxes = uiaxes(app.AboutEZFigure, 'Position', [5 60 200 160], ...
                'BackgroundColor', 'w');
            
            app.logButton = uibutton(app.AboutEZFigure, 'Position', [100 20 105 20], 'Text', 'Develop log', ...
                'BackgroundColor', 'w', 'ButtonPushedFcn', @(source, event) logButtonPushedFcn(app, source, event));
            
            % app.verLabel = uilabel(app.AboutEZFigure, 'Position', [220 180 200 45], 'BackgroundColor', 'w', ...
            %     'Text', {'Version: EZ.2018.sp (1.0)'; 'May 16, 2018'; 'Licence: developer'});
            
            % enable imageshow on or off, 6/11/2018
            % app.verLabel = uilabel(app.AboutEZFigure, 'Position', [220 180 200 45], 'BackgroundColor', 'w', ...
            %     'Text', {'Version: EZ.2018.sp (1.1)'; 'June 11, 2018'; 'Licence: developer'});
            
            % enable write while analyze, 6/14/2018
            % app.verLabel = uilabel(app.AboutEZFigure, 'Position', [220 180 200 45], 'BackgroundColor', 'w', ...
            %     'Text', {'Version: EZ.2018.sp (1.2)'; 'June 14, 2018'; 'Licence: developer'});
            
            % enable add results to existing files, 6/18/2018
            % app.verLabel = uilabel(app.AboutEZFigure, 'Position', [220 180 200 45], 'BackgroundColor', 'w', ...
            %     'Text', {'Version: EZ.2018.sp (1.3)'; 'June 18, 2018'; 'Licence: developer'});
            
            % add symbolic distribution entropy, 10/5/2018
            app.verLabel = uilabel(app.AboutEZFigure, 'Position', [220 180 200 45], 'BackgroundColor', 'w', ...
                'Text', {'Version: EZ.2018.sp (1.4)'; 'October 5, 2018'; 'Licence: developer'});
            
            app.rightLabel = uilabel(app.AboutEZFigure, 'Position', [220 120 200 45], 'BackgroundColor', 'w', ...
                'Text', {'© 2018-2020 Peng Li'; 'A product of E-Z Lab.'; 'Developer: Peng Li, Ph.D.'});
            
            app.ackLabel = uilabel(app.AboutEZFigure, 'Position', [220 20 200 85], 'BackgroundColor', 'w', ...
                'Text', {'Acknowledgment:'; 'MATLAB is registered trademarks'; 'of The MathWorks, Inc.'; ''; 'A deep sense of gratitude to my'; 'wife, my son, and my daughter.'});
        end
    end
    
    methods (Access = private)
        function app = logButtonPushedFcn(app, source, event)
            
        end
    end
end