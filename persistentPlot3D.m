function persistentPlot3D(x, y, z)

persistent h fig ax initialized

if isempty(initialized) || isempty(h) || ~isvalid(h)
    fig = figure;
    ax = axes(fig);

    h = animatedline(ax, ...
        'LineWidth', 2, ...
        'Color', 'b');

    grid(ax, 'on');
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    zlabel(ax, 'z');
    title(ax, '3D trajectory from x-y-z signals');
    view(ax, 3);

    % Set aspect ratio first
    daspect(ax, [1 1 1]);

    % Then force fixed limits
    xlim(ax, [-20 20]);
    ylim(ax, [-20 20]);
    zlim(ax, [-10 200]);

    ax.XLimMode = 'manual';
    ax.YLimMode = 'manual';
    ax.ZLimMode = 'manual';

    initialized = true;
end

% Re-apply limits every update so Simulink/MATLAB cannot autoscale them
xlim(ax, [-20 20]);
ylim(ax, [-20 20]);
zlim(ax, [-10 200]);

addpoints(h, double(x), double(y), double(z));
drawnow limitrate;

end