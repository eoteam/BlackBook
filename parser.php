<?php
	
	$newdir = "Resources/images/eddie/";
	$dir = opendir($newdir);
	
	if($dir)
	{
		while(($file = readdir($dir)) !== false)
		{
			
			if($file !== "." && $file !== ".." && $file != "migThumbs" && $file != ".DS_Store")
			{
				
				if(is_file($newdir.$file))
				{	
					$size = getimagesize($newdir.$file);
					echo '{"wratio":"'. $size[0] . '","hratio":"'.  $size[1] .'","name":"'. $file . '","info":"","color":""}<br>';
				}
			}
		}
	}     	
	
?>



