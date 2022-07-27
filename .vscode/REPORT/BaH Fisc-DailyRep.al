report 50005 "BaH Fisc-DailyRep"
{
    // BH1.00, Fiscal Process

    Caption = 'Daily report';
    ProcessingOnly = true;
    UseRequestPage = true;
    /*
        dataset
        {
        }

        /*requestpage
        {

            layout
            {
                area(content)
                {
                  group()
                    {
                        InstructionalText = 'With this process you will execute daily invoice printing. Are you sure you want to do this?';
                    }
                }
            }

            actions
            {
            }
        }

        labels
        {
        }*/

    trigger OnPreReport()
    begin
        //    FiscalPrinterMgmt.DailyReport;
    end;

    var
    //ĐK FiscalPrinterMgmt: Codeunit "BaH FiscalPrintersMgmt";
}

