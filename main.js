// Visitor counter (Cloud Resume Challenge, step 7)
//
// Once your Azure Function is deployed (steps 8-10), paste its URL below.
// Until then the counter shows a dash and the page works normally.
const API_URL = "https://func-cloudresume-ascbox-gpfgfyhgcag0ceb6.eastus-01.azurewebsites.net/api/visitorcount"; // e.g. "https://<your-function-app>.azurewebsites.net/api/visitorcount"

async function updateVisitorCount() {
  const el = document.getElementById("visitor-count");
  if (!API_URL) return; // backend not built yet

  try {
    const response = await fetch(API_URL, { method: "POST" });
    if (!response.ok) throw new Error(`API returned ${response.status}`);
    const data = await response.json();
    el.textContent = Number(data.count).toLocaleString();
  } catch (err) {
    console.error("Visitor counter failed:", err);
    // leave the dash in place so the page never looks broken
  }
}

updateVisitorCount();
