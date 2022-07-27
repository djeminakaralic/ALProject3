report 50002 "BaH Fisc-PeriodReport"
{
    // BH1.00, Fiscal Process

    Caption = 'Report by period';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(FromDate; FromDate)
                {
                    Caption = 'Starting date';
                }
                field(ToDate; ToDate)
                {
                    Caption = 'Ending date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        ToDate := CALCDATE('<-1D>', TODAY);
        FromDate := CALCDATE('<-1W>', ToDate);
    end;

    trigger OnPreReport()
    begin
        IF (FromDate = 0D) OR (ToDate = 0D) THEN ERROR(ERROR_WRONG_DATE);
        IF FromDate > ToDate THEN ERROR(ERROR_WRONG_DATES);

        //    FiscalPrinterMgmt.PeriodReport(FromDate, ToDate);
    end;

    var
        // FiscalPrinterMgmt: Codeunit "BaH FiscalPrintersMgmt";
        FromDate: Date;
        ToDate: Date;
        ERROR_WRONG_DATE: Label 'Morate unijeti oba datuma!';
        ERROR_WRONG_DATES: Label 'Morate unijeti validan period!';
}

