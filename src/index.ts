import { registerPlugin } from '@capacitor/core';

import type { FilePreviewPlugin } from './definitions';

const FilePreview = registerPlugin<FilePreviewPlugin>('FilePreview', {
  web: () => import('./web').then(m => new m.FilePreviewWeb()),
});

export * from './definitions';
export { FilePreview };
