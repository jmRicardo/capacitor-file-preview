export interface FilePreviewPlugin {
  openFile(options: { path: string, mediaType?: string }): Promise<{ path: string, mediaType?: string }>;
}
