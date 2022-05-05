pageextension 50106 PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here

        addafter(ActivityLog)
        {

            group(Fiscal)
            {
                Caption = 'Fiscal';
                Image = Print;


                /*   group(Fiscal2)
                   {
                       Caption = 'Fiscal2';
                       Image = Print;*/

                action("Cross section")
                {
                    Caption = 'Cross section';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;


                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Putanja := 'C:\tring\xml\';
                        File1.CREATE(Putanja + 'stampatipresjekstanja.xml', TEXTENCODING::UTF8);
                        File1.CREATEOUTSTREAM(OutStreamObj);
                        Plite := '<?xml version="1.0" encoding="utf-8"?>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<BrojZahtjeva>198020</BrojZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<VrstaZahtjeva>3</VrstaZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Parametri />';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '</Zahtjev>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        File1.CLOSE;
                        FileManagement.DownloadToFile(Putanja + 'stampatipresjekstanja.xml', Putanja + 'stampatipresjekstanja.xml');
                        COMMIT;


                        //Odgovor('\\SERVER6\Temp2\XML\odgovori\sps');
                    end;
                }
                action("Print Daily report")
                {
                    Caption = 'Print Daily report';
                    Image = Print;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;


                    trigger OnAction()
                    begin
                        Putanja := 'C:\tring\xml\';
                        File1.CREATE(Putanja + 'stampatidnevniizvjestaj.xml', TEXTENCODING::UTF8);
                        File1.CREATEOUTSTREAM(OutStreamObj);
                        Plite := '<?xml version="1.0" encoding="utf-8"?>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001FileManagement.DownloadToFile(filename,filename);/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<BrojZahtjeva>61529</BrojZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<VrstaZahtjeva>4</VrstaZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Parametri />';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '</Zahtjev>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        File1.CLOSE;

                        //Odgovor('\\SERVER6\Temp2\XML\odgovori\StampatiDnevniIzvjestaj');
                        FileManagement.DownloadToFile(Putanja + 'stampatidnevniizvjestaj.xml', Putanja + 'stampatidnevniizvjestaj.xml');
                        COMMIT;
                    end;
                }
                action("Print Periodic report")
                {
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;


                    Caption = 'Print Periodic report';
                    Image = Print;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Periodic report - fiscal";
                }
            }
            // }
        }


    }


    var
        myInt: Integer;
        Putanja: Text[1000];
        File1: File;
        Plite: Text;
        OutStreamObj: OutStream;
        Periodicreportfiscal: Report "Periodic report - fiscal";
        TXTTab: Char;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text;
        x5: Text;
        X6: Text;
        x1: Text;
        x2: Text;
        x3: Text;
        x4: Text;
        Zamjena: Text;
        ReadLine2: Text;
        VrstaOdgovora: Text;
        strInStream: InStream;
        XMLFileOutStr: OutStream;
        ToFileName: Text;
        FileManagement: Codeunit "File Management";


}
