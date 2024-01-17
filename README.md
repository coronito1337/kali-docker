<h2>Kali Docker</h2>
<p>Dockerfile containing a minimalistic Kali Linux instance.</p>
<p>The most used tools were compiled to keep it ready to use, but staying light enough to run on any PC.</p>
<p>For shell we're using ZSH with the Oh-My-Zsh <a href="https://github.com/coronito1337/pentester-theme">Pentester </a> theme.</p>
<p>Example on how to build the image</p>
<p><code>docker build . -t kali</code></p>
<p><code>-t</code> sets the image name</p>
<br>
<p>Example on how to launch the container</p>
<p><code>docker run --name kali -p 1337:1337 -p 8000:8000 -v C:\src_folder_path:/dst_folder_path -it kali</code></p>
<p><code>-p src:dest</code> forwards the designated ports</p>
<p><code>-v src:dest</code> creates a volume from the host location to </p>
<p><code>--name</code> sets the container name</p>