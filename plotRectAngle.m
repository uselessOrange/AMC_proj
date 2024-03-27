function plotRectAngle(a,b,ycentre)
    width=b-a;
    y = ycentre-width/2;      % y-coordinate of the bottom-left corner
    height = width; % height of the rectangle
    
    % Plotting the rectangle
    
    rectangle('Position', [a, y, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
    
    % Set axis labels and title
%     xlabel('X-axis');
%     ylabel('Y-axis');
%     title('Rectangle Plot');
    
    % Adjust axis limits if needed
%     axis equal;  % Equal scaling for x and y axes
%     grid on;     % Show grid lines
end
