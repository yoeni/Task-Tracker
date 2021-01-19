using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using System;
using System.Diagnostics;

namespace TaskTrackerTest
{
    public class Tests
    {
        IWebDriver driver = new ChromeDriver();
        [SetUp]
        public void Setup()
        {
            driver.Navigate();
        }

        [Test]
        public void kullaniciGirisi(bool via)
        {

            siteAc("https://localhost:44323");
            while (!isComplete())
            {
                if (isComplete())
                {
                    break;
                }
            }
            driver.FindElement(By.Name("username")).SendKeys("sezer123");
            driver.FindElement(By.Name("password")).SendKeys("123456");
            driver.FindElement(By.Id("LinkButton1")).Click();
            if (!via)
            {
                Assert.Pass();
            }
        }
        [Test]
        public void gorevEkleme()
        {
            kullaniciGirisi(true);
            System.Threading.Thread.Sleep(1000);

            try
            {
                driver.FindElement(By.Name("addtaskhref")).Click();
            }
            catch (System.Exception e)
            {
                driver.FindElement(By.Name("addtaskhrefmobile")).Click();
            }

            System.Threading.Thread.Sleep(1000);

            driver.FindElement(By.Name("taskname")).SendKeys("testTask  ");
            driver.FindElement(By.Name("projectno")).SendKeys("test rpject");
            driver.FindElement(By.Name("taskpredate")).SendKeys("12/01/2020");
            driver.FindElement(By.Name("taskenddate")).SendKeys("11/01/2021");
            driver.FindElement(By.Name("notes")).SendKeys("123456");
            driver.FindElement(By.Id("savebutton")).Click();
            Assert.Pass();
        }
        [Test]
        public void gorevKategoriDegistirme()
        {
            kullaniciGirisi(true);

            var task = driver.FindElement(By.XPath("//*[@id=\"todolist\"]/li"));
            var dest = driver.FindElement(By.XPath("//*[@id=\"inprogresslist\"]"));

            Actions builder1 = new Actions(driver);
            builder1.Release(task).ClickAndHold(task).MoveToElement(dest).Release(dest).Build().Perform();
            System.Threading.Thread.Sleep(1000);
            driver.FindElement(By.Id("savebutton")).Click();
            Assert.Pass();
        }
        public bool isComplete()
        {

            IJavaScriptExecutor jse = (IJavaScriptExecutor)driver;
            return ((jse.ExecuteScript("return document.readyState;")).ToString() == "complete" ? true : false);

        }
        void siteAc(string url)
        {
            driver.Navigate().GoToUrl(url);
            System.Threading.Thread.Sleep(1000);
        }
    }
}