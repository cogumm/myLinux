export type ConfirmDialogHandle = {
  root: HTMLDialogElement;
  ask: (message: string) => Promise<boolean>;
};

export function createConfirmDialog(): ConfirmDialogHandle {
  const dialog = document.createElement("dialog");
  dialog.id = "confirm-dialog";
  dialog.className = "dialog";
  dialog.setAttribute("aria-labelledby", "confirm-title");

  const form = document.createElement("form");
  form.method = "dialog";
  form.className = "dialog__card";

  const title = document.createElement("h2");
  title.id = "confirm-title";
  title.textContent = "Confirmar";

  const text = document.createElement("p");
  text.id = "confirm-text";
  text.className = "dialog__text";

  const actions = document.createElement("div");
  actions.className = "dialog__actions";

  const cancel = document.createElement("button");
  cancel.type = "submit";
  cancel.value = "cancel";
  cancel.className = "btn";
  cancel.textContent = "Cancelar";

  const ok = document.createElement("button");
  ok.type = "submit";
  ok.value = "ok";
  ok.className = "btn btn--accent";
  ok.id = "confirm-ok";
  ok.textContent = "Continuar";

  actions.append(cancel, ok);
  form.append(title, text, actions);
  dialog.append(form);

  return {
    root: dialog,
    ask(message) {
      text.textContent = message;
      dialog.showModal();
      return new Promise((resolve) => {
        const onClose = (): void => {
          dialog.removeEventListener("close", onClose);
          resolve(dialog.returnValue === "ok");
        };
        dialog.addEventListener("close", onClose);
      });
    },
  };
}
