import { WebPlugin } from '@capacitor/core';

import type { FilePreviewPlugin } from './definitions';

export class FilePreviewWeb extends WebPlugin implements FilePreviewPlugin {
  openFile(options: { path: string; mimeType: string; }): Promise<{ path: string, mediaType: string }> {
    console.log('ECHO', options);
    throw this.unimplemented('Not implemented on web.');
  }
}
