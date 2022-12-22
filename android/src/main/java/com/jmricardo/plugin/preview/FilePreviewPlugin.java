package com.jmricardo.plugin.preview;
import android.content.Intent;
import android.net.Uri;
import android.provider.MediaStore;
import android.webkit.MimeTypeMap;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "FilePreview")
public class FilePreviewPlugin extends Plugin {

    private FilePreview implementation = new FilePreview();
    private String mimeType = null;

    @PluginMethod
    public void openFile(PluginCall call) {
        var url = call.getString("path");
        var baseType = call.getString("mimeType");
        var uri = Uri.parse(url);
        mimeType = setMimeType(baseType, url);

        Intent intent = new Intent(Intent.ACTION_VIEW, MediaStore.Downloads.EXTERNAL_CONTENT_URI);
        intent.setDataAndType(uri, mimeType);
        getActivity().startActivity(intent);

        call.resolve();
    }

    private String setMimeType(String baseType, String path){
        String mimeType = notEmpty(baseType) ? baseType : pathToMime(path);
        if (!notEmpty(mimeType))
            mimeType = "application/*";
        return mimeType;
    }

    private String pathToMime(String url) {
        String mimeType = null;
        String extension = MimeTypeMap.getFileExtensionFromUrl(url);
        if (notEmpty(extension))
            mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension);
        return mimeType;
    }

    private static boolean notEmpty(String x) {
        return x != null && !"".equals(x) && !"null".equalsIgnoreCase(x);
    }
}
