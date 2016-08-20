function gui_plots

% GUI_PLOTS Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.


% Create and then hide the UI as it is being constructed.
f = figure('Visible', 'off', 'Position', [360,500,450,285]);

% Construct the components
hsurf = uicontrol('Style', 'pushbutton', ...
            'String', 'Surf', 'Position', [315,220,70,25], ...
            'Callback', {@surfbutton_Callback});

hmesh = uicontrol('Style', 'pushbutton', ...
            'String', 'Mesh', 'Position', [315,180,70,25], ...
            'Callback', {@meshbutton_Callback});
        
hcontour = uicontrol('Style', 'pushbutton', ...
            'String', 'Countour', 'Position', [315,135,70,25], ...
            'Callback', {@contourbutton_Callback});

htext = uicontrol('Style','text','String','Select Data', ...
    'Position', [325,90,100,15]);

hpopup = uicontrol('Style', 'popupmenu', ...
    'String', {'Peaks', 'Membrane', 'Sinc'}, ...
    'Position', [300, 50, 100, 25], ...
    'Callback', {@popup_menu_Callback});

ha = axes('Units', 'Pixels', 'Position', [50,60,200,185]);
align([hsurf,hmesh,hcontour,htext,hpopup],'Center','None');

% Initialize the UI
% Change units to normalized so components resize automatically
f.Units = 'normalized';
ha.Units = 'normalized';
hsurf.Units = 'normalized';
hmesh.Units = 'normalized';
hcontour.Units = 'normalized';
htext.Units = 'normalized';
hpopup.Units = 'normalized';

% Generate the data plot
peaks_data = peaks(35);
membrane_data = membrane;

% Create a plot in the axes
current_data = peaks_data;
surf(current_data);

% Assign a name to appear  in the window title
f.Name = 'Simple GUI';

% Move the window to the center of the screen
movegui(f,'center');

% Make the gui visible
f.Visible = 'on';

% Program the popup-menu
    function popup_menu_Callback(source,eventdata)
        % Determine the selected dataset
        str = source.String;
        val = source.Value;
        disp(str);
        disp(str{val});
        % Set current data to selected dataset
        switch str{val}
            case 'Peaks'
                current_data = peaks_data;
            case 'Membrane'
                current_data = membrane_data;
            case 'Sinc'
                current_data = sinc_data;
        end
    end

% Program the pushbuttons
% Push button callbacks. Each callback plots current_data
    function surfbutton_Callback(source,eventdata)
        surf(current_data);
    end

    function meshbutton_Callback(source,eventdata)
        mesh(current_data);
    end

    function contourbutton_Callback(source,eventdata)
        contour(current_data);
    end

% Continue --> Create UI programmatically : pag 277 / 508
% Continue UI with GUIDE : pag 69 / 508

end