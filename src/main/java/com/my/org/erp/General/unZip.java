package com.my.org.erp.General;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

 
public class unZip {
	public static final int LIST = 0, EXTRACT = 1;
	protected int mode = LIST;
	protected ZipFile zippy;
	protected byte[] b;
	public static void main(String[] argv) 
	{
		unZip u = new unZip();
		for (int i=0; i<argv.length; i++) 
		{
			if ("-x".equals(argv[i])) {
				u.setMode(EXTRACT);
				continue;
				
				
				
		}
		String candidate = "../webapps/SmartCampus/Zip/src.zip";
		if (candidate.endsWith(".zip") || candidate.endsWith(".jar"))
					u.unZipg(candidate);
		else System.err.println("Not a zip file? " + candidate);
		}
		System.err.println("All done!");
	}

	
	unZip() 
	{
		b = new byte[8092];
	}

	protected void setMode(int m) 
	{
		if (m == LIST ||
		    m == EXTRACT)
			mode = m;
	}

	
	protected SortedSet dirsMade;

	public void unZipg(String fileName) 
	{
		dirsMade = new TreeSet();
		try {
			zippy = new ZipFile(fileName);
			Enumeration all = zippy.entries();
			while (all.hasMoreElements()) {
				getFile((ZipEntry)all.nextElement());
			}
		} catch (IOException err) {
			System.err.println("IO Error: " + err);
			return;
		}
	}

	protected boolean warnedMkDir = false;
	@SuppressWarnings("unchecked")
	protected void getFile(ZipEntry e) throws IOException {
		String zipName = e.getName();
		switch (mode) {
		case EXTRACT:
			if (zipName.startsWith("/")) {
				if (!warnedMkDir)
					//System.out.println("Ignoring absolute paths");
				warnedMkDir = true;
				zipName = zipName.substring(1);
			}
			// if a directory, just return. We mkdir for every file,
			// since some widely-used Zip creators don't put out
			// any directory entries, or put them in the wrong place.
			if (zipName.endsWith("/")) {
				return;
			}
			// Else must be a file; open the file for output
			// Get the directory part.
			int ix = zipName.lastIndexOf('/');
			if (ix > 0) {
				String dirName = zipName.substring(0, ix);
				if (!dirsMade.contains(dirName)) {
					File d = new File(dirName);
					// If it already exists as a dir, don't do anything
					if (!(d.exists() && d.isDirectory())) {
						// Try to create the directory, warn if it fails
						//System.out.println("Creating Directory: " + dirName);
						if (!d.mkdirs()) {
							System.err.println(
							"Warning: unable to mkdir " + dirName);
						}
						dirsMade.add(dirName);
					}
				}
			}
			System.err.println("Creating " + zipName);
			FileOutputStream os = new FileOutputStream(zipName);
			InputStream  is = zippy.getInputStream(e);
			int n = 0;
			while ((n = is.read(b)) >0)
				os.write(b, 0, n);
			is.close();
			os.close();
			break;
		case LIST:
			// Not extracting, just list
			if (e.isDirectory()) {
				//System.out.println("Directory " + zipName);
			} else {
				//System.out.println("File " + zipName);
			}
			break;
		default:
			throw new IllegalStateException("mode value (" + mode + ") bad");
		}
	}
}