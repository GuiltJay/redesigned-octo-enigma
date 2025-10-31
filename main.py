from fastapi import FastAPI, Query, Response
from playwright.async_api import async_playwright
import asyncio

app = FastAPI(title="Screenshot API", version="1.0")

@app.get("/")
async def root():
    return {"message": "Screenshot API running!"}

@app.get("/screenshot")
async def screenshot(url: str = Query(..., description="Target website URL")):
    async with async_playwright() as p:
        browser = await p.chromium.launch(args=["--no-sandbox"])
        page = await browser.new_page()
        await page.goto(url, timeout=60000)
        img = await page.screenshot(full_page=True)
        await browser.close()
    return Response(content=img, media_type="image/png")