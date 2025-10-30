function butterfly()
  % BUTTERFLY - Animated butterfly curve with persistent colors + music

  try
    graphics_toolkit("qt");
  catch
  end

  % --- Load and play song ---
  [y, Fs] = audioread('butter.wav');   % Make sure butter.wav is in the same folder
  player = audioplayer(y, Fs);
  play(player);  % start playing asynchronously

  % --- Theta and parameters ---
  theta_deg = linspace(0, 4320, 5000);
  theta = theta_deg * pi / 180;
  a0 = 2.0; n0 = 4.0; d0 = 12.0;

  % --- Figure setup ---
  figure('Color', 'k');
  hold on;
  axis equal;
  axis([-6 6 -6 6]);
  axis off;

  % --- Color segments ---
  color_map = {'m', 'c', 'y', 'r', 'g'};
  color_segments = [0, 1000, 2000, 3000, 4000, 4320];
  seg_duration = 8; % seconds per 1000 deg

  % STEP 1: Draw butterfly growing
  for seg = 1:length(color_segments)-1
    idx = find(theta_deg >= color_segments(seg) & theta_deg < color_segments(seg+1));
    th = theta(idx);
    num_points = length(th);
    pause_time = seg_duration / num_points;

    for i = 1:num_points
      x = exp(sin(th(1:i))) - a0 .* cos(n0 .* th(1:i)) + (sin(th(1:i) ./ d0)).^5;
      x = x .* cos(th(1:i));
      y = exp(sin(th(1:i))) - a0 .* cos(n0 .* th(1:i)) + (sin(th(1:i) ./ d0)).^5;
      y = y .* sin(th(1:i));

      plot(x, y, color_map{seg}, 'LineWidth', 1.8);
      drawnow;
      pause(pause_time);
    end
  end

  % STEP 2: Morph parameter 'a'
  a_seq = [linspace(2.0,1.5,60), linspace(1.5,2.5,120), linspace(2.5,2.0,60)];
  for a = a_seq
    r = exp(sin(theta)) - a .* cos(n0 .* theta) + (sin(theta ./ d0)).^5;
    x = r .* cos(theta); y = r .* sin(theta);
    cla;
    plot(x, y, 'm', 'LineWidth', 1.8);
    axis equal; axis([-6 6 -6 6]); axis off;
    title(sprintf('Flap a = %.2f', a), 'Color', 'w');
    drawnow;
    pause(0.10);
  end

  % STEP 3: Morph parameter 'n'
  n_seq = [linspace(4,3,60), linspace(3,4,60), linspace(4,5,60), linspace(5,6,60), linspace(6,4,120)];
  for n = n_seq
    r = exp(sin(theta)) - a0 .* cos(n .* theta) + (sin(theta ./ d0)).^5;
    x = r .* cos(theta); y = r .* sin(theta);
    cla;
    plot(x, y, 'y', 'LineWidth', 1.8);
    axis equal; axis([-6 6 -6 6]); axis off;
    title(sprintf('Pattern n = %.2f', n), 'Color', 'w');
    drawnow;
    pause(0.10);
  end

  % STEP 4: Morph parameter 'd'
  d_seq = [linspace(12,20,80), linspace(20,12,80)];
  for d = d_seq
    r = exp(sin(theta)) - a0 .* cos(n0 .* theta) + (sin(theta ./ d)).^5;
    x = r .* cos(theta); y = r .* sin(theta);
    cla;
    plot(x, y, 'r', 'LineWidth', 1.8);
    axis equal; axis([-6 6 -6 6]); axis off;
    title(sprintf('Inner wave d = %.2f', d), 'Color', 'w');
    drawnow;
    pause(0.10);
  end

  % Final frame
  cla;
  r = exp(sin(theta)) - a0 .* cos(n0 .* theta) + (sin(theta ./ d0)).^5;
  plot(r.*cos(theta), r.*sin(theta), 'w', 'LineWidth', 2);
  axis equal; axis([-6 6 -6 6]); axis off;
  title('Final Butterfly 🦋', 'Color', 'w');

  % Stop the song when done
  stop(player);
end

