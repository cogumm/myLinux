export type LogKind = "default" | "info" | "error" | "cmd";

function escapeHtml(text: string): string {
  return text
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

/** Tokenize plain log text into colored spans (Dracula-like). */
export function highlightLogLine(raw: string, kind: LogKind = "default"): string {
  if (kind === "error" || /^\s*\[erro\]/i.test(raw)) {
    return `<span class="tok-err">${escapeHtml(raw)}</span>`;
  }

  if (kind === "cmd" || /^\s*\$\s/.test(raw)) {
    return `<span class="tok-info">${escapeHtml(raw)}</span>`;
  }

  if (kind === "info") {
    return `<span class="tok-info">${escapeHtml(raw)}</span>`;
  }

  if (/^\s*\[exit\s+0\]\s*$/i.test(raw)) {
    return `<span class="tok-prop">[exit </span><span class="tok-num">0</span><span class="tok-prop">]</span>`;
  }

  const exitFail = raw.match(/^(\s*\[exit\s+)(\d+)(\]\s*)$/i);
  if (exitFail) {
    return `<span class="tok-err">${escapeHtml(exitFail[1])}<span class="tok-num">${escapeHtml(exitFail[2])}</span>${escapeHtml(exitFail[3])}</span>`;
  }

  let out = "";
  const re =
    /("(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')|\b(true|false|null)\b|\b(0x[0-9a-fA-F]+|\d+(?:\.\d+)?)\b|(\b[A-Za-z_][\w.-]*\b)(?=\s*[:=])/g;
  let last = 0;
  let m: RegExpExecArray | null;
  while ((m = re.exec(raw)) !== null) {
    out += escapeHtml(raw.slice(last, m.index));
    if (m[1]) out += `<span class="tok-str">${escapeHtml(m[1])}</span>`;
    else if (m[2]) out += `<span class="tok-bool">${escapeHtml(m[2])}</span>`;
    else if (m[3]) out += `<span class="tok-num">${escapeHtml(m[3])}</span>`;
    else if (m[4]) out += `<span class="tok-prop">${escapeHtml(m[4])}</span>`;
    last = m.index + m[0].length;
  }
  out += escapeHtml(raw.slice(last));
  return out;
}
