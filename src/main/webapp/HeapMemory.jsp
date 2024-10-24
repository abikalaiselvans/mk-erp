<%
// Get current size of heap in bytes
long heapSize = Runtime.getRuntime().totalMemory();

// Get maximum size of heap in bytes. The heap cannot grow beyond this size.
// Any attempt will result in an OutOfMemoryException.
long heapMaxSize = Runtime.getRuntime().maxMemory();

// Get amount of free memory within the heap in bytes. This size will increase
// after garbage collection and decrease as new objects are created.
long heapFreeSize = Runtime.getRuntime().freeMemory();


Runtime runtime = Runtime.getRuntime();
runtime.gc();
long memory = runtime.totalMemory() - runtime.freeMemory();
out.println("<br><b>Used memory is bytes: </b>" + memory);
out.println("<br><b>Used memory is megabytes: </b>"+ bytesToMegabytes(memory));


out.println("<br><b>Heap Size</b>   :"+heapSize);
out.println("<br><b>Heap Max Size</b>   :"+heapMaxSize);
out.println("<br><b>Heap Free Size</b>   :"+heapFreeSize);
 %>
 
 <%!
 private static final long MEGABYTE = 1024L * 1024L;

	public static long bytesToMegabytes(long bytes) {
		return bytes / MEGABYTE;
	}

 %>