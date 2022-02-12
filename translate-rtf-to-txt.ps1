Function translate-rtf-txt
{
<#		
.SYNOPSIS
	Converts *.rtf file to *.txt file
.DESCRIPTION
	Uses .NET to do this (based on C# technet howto: http://msdn.microsoft.com/en-us/library/cc488002.aspx)
	negating the use of MS Word to perform the translation (which is how most sources online seem to do it).
				
.PARAMETER
	-src_file 		# Full path to source *.rtf file
.OUTPUT
	*.txt file with original source filename is generated in the same directory	
.EXAMPLE
	translate-rtf-txt -src_file "c:\path\to\file.rtf"
#>
  	Param
	(
		[System.Io.FileInfo] $src_file 
	)  
  	Begin
	{
    	$getFunctionName = '{0}' -f $MyInvocation.MyCommand
		Write-Host "INFO: Function $getFunctionName started." 
 	}  
  	Process
	{
		#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion
    	Try
		{
      		# Create destination file name
			$dest_file_name_no_ext = join-path $src_file.DirectoryName  $src_file.BaseName
			$dest_file_name = $dest_file_name_no_ext + ".txt"
			Write-Host "Copying from $src_file to $dest_file_name"
			
			# Load *.rtf file into a hidden .NET RichTextBox
			$rtBox = New-Object System.Windows.Forms.RichTextBox
			$rtfText = [System.IO.File]::ReadAllText($src_file);
			$rtBox.Rtf = $rtfText
			
			# Get plain text version
			$plainText = $rtBox.Text;
			
			# Write the plain text out to the destination file
			[System.IO.File]::WriteAllText($dest_file_name, $plainText)
    	}    
    	Catch
		{
      		Write-Host $_.Exception
      		Break
    	}
  	}  
 	End
	{
    	If($?)
		{
		      Write-Host "INFO: Execution of function $getFunctionName completed successfully." 
    	}
  	}
} #END Function translate-rtf-txt#