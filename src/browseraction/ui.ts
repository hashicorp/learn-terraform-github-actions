export interface UIDef {
  txtArea: HTMLTextAreaElement;
  domain: HTMLInputElement;
  openButton: HTMLInputElement;
  preserveCheckbox: HTMLInputElement;
  closeTabs: HTMLInputElement;
  sourceTag: HTMLInputElement;
  page: HTMLInputElement;
}

export function getUIDef(): UIDef {
  return {
    txtArea: document.getElementById('kws') as HTMLTextAreaElement,
    domain: document.getElementById('domain') as HTMLInputElement,
    preserveCheckbox: document.getElementById('preserve') as HTMLInputElement,
    closeTabs: document.getElementById('closeTabs') as HTMLInputElement,
    openButton: document.getElementById('open') as HTMLInputElement,
    sourceTag: document.getElementById('sourcetag') as HTMLInputElement,
    page: document.getElementById('page') as HTMLInputElement,
  };
}
