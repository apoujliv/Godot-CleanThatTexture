<h1>Install Instructions:</h1>
<a href="https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html#installing-a-plugin">[Godot Documentation]</a>. Install with zip folder.

<h1>Usage:</h1>
<h2>Requirements:</h2>
<ul>
  <l1>Foreground Texture</l1>
  <l1>Background Texture</l1>
  <li>Optional: particle emitter</li>
</ul>

<h2>Properties:</h2>
<ul>
  <li><b>Front Image</b> - The texture initially displayed / the texture to be wiped away.</li>
  <li><b>Enable Background Image</b> - Show/hide the background image.</li>
  <li><b>Back Image</b> - The texture initially hidden / the texture to be shown after wipe. Only active if Enable Background Image is true.</li>
  <li><b>Line Width</b> - The width of the brush for removing the top texture</li>
  <li><b>Wait Time</b> - Active drawing time before fading out the top texture. Only ticks down while drawing.</li>
  <li><b>Enable Emitter</b> - Enables emitter off of the drawing brush.</li>
  <li><b>Max Point Count</b> - Max number of line points allowed before fading out the top texture.</li>
  <li><b>Emitter Import</b> - Custom emitter to emit from drawing brush. Only active if Enable Emitter is true.</li>
</ul>

<h2>Use in Project:</h2>
<ol>
  <li>Set up scene</li>
  <li>Open res://addons/texture_cleaner</li>
  <li>Locate texture_cleaner.tscn</li>
  <img width="295" height="221" alt="image" src="https://github.com/user-attachments/assets/0d076580-7435-463f-b500-b7db087e40e1" />
  <li>Drag tscn to node</li>
  <img width="301" height="213" alt="image" src="https://github.com/user-attachments/assets/cadb0106-b1a4-4b2a-b8cb-97f4f2a754d6" />
  <li>Right click on "Node", enable "Editable Children"</li>
  <img width="511" height="772" alt="image" src="https://github.com/user-attachments/assets/970571ac-051e-4fbb-b3a5-9fb42501019a" />
  <li>Click on "TextureWipe" node. Adjust properties as needed.</li> 
</ol>
