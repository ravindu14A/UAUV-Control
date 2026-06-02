% Extract actual trajectory
x = squeeze(out.x_out.Data);
y = squeeze(out.y_out.Data);
z = squeeze(out.z_out.Data);

% Extract reference trajectory
x_ref = squeeze(out.x_ref_out.Data);
y_ref = squeeze(out.y_ref_out.Data);
z_ref = squeeze(out.z_ref_out.Data);

% Force column vectors
x = x(:);
y = y(:);
z = z(:);

x_ref = x_ref(:);
y_ref = y_ref(:);
z_ref = z_ref(:);

% Plot
figure;

plot3(x, y, z, 'b-', 'LineWidth', 2);
hold on;

plot3(x_ref, y_ref, z_ref, 'r:', 'LineWidth', 2);

grid on;
xlabel('x');
ylabel('y');
zlabel('z');
title('3D trajectory: actual vs reference');

legend('Actual trajectory', 'Reference trajectory', 'Location', 'best');

% Fixed axes
xlim([-20 20]);
ylim([-20 20]);
zlim([-20 200]);

% Make axis increments visually equivalent
daspect([1 1 1]);

view(3);
hold off;