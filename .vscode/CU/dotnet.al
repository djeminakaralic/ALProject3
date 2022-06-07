dotnet
{
    assembly("Microsoft.VisualBasic")
    {
        Version = '10.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("Microsoft.VisualBasic.DateAndTime"; "DateAndTime")
        {
        }

        type("Microsoft.VisualBasic.FirstDayOfWeek"; "FirstDayOfWeek")
        {
        }

        type("Microsoft.VisualBasic.FirstWeekOfYear"; "FirstWeekOfYear")
        {
        }
    }


    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Diagnostics.Process"; "Process")
        {
        }

        type("System.Diagnostics.DataReceivedEventArgs"; "DataReceivedEventArgs")
        {
        }
    }


    assembly("mscorlib")
    {
        Version = '2.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';



        type("System.Reflection.BindingFlags"; "BindingFlags")
        {
        }
        type("System.RuntimeTypeHandle"; "RuntimeTypeHandle")
        {
        }


    }

    assembly("Microsoft.Office.Interop.Excel")
    {
        Version = '15.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '71e9bce111e9429c';



        type("Microsoft.Office.Interop.Excel.Workbook"; "Workbook")
        {
        }

        type("Microsoft.Office.Interop.Excel.Application"; "Application")
        {
        }

        type("Microsoft.Office.Interop.Excel.ApplicationClass"; "ApplicationClass2")
        {
        }

        type("Microsoft.Office.Interop.Excel.Workbooks"; "Workbooks")

        {
        }

        type("Microsoft.Office.Interop.Excel.Worksheet"; WorkSheet2)
        {

        }


    }



    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        //System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
        type("System.Xml.XmlDocument"; SystemXmlDocument)
        {

            //System.Xml.XmlDocument.'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'

        }
        type("System.Xml.XmlNodeList"; SystemXmlNodeList) { }
        type("System.Xml.XmlNodeType"; SystemXmlNodeType) { }
        type("System.Xml.XmlNamedNodeMap"; SystemXmlNamedNodeMap) { }
        type("System.Xml.XmlNode"; SystemNode) { }
        type("System.Xml.XmlNode"; SystemXmlNode) { }
    }
    assembly("PdfSharp")
    {
        Version = '1.32.2608.0';
        Culture = 'neutral';
        PublicKeyToken = 'f94615aa0424f9eb';

        type("PdfSharp.Pdf.IO.PdfReader"; "PdfReader")
        {
        }

        type("PdfSharp.Pdf.PdfDocument"; "PdfDocument")
        {
        }

        type("PdfSharp.Pdf.Security.PdfSecuritySettings"; "PdfSecuritySettings")
        {
        }

        type("PdfSharp.Pdf.IO.PdfDocumentOpenMode"; "PdfDocumentOpenMode")
        {
        }
    }

}
