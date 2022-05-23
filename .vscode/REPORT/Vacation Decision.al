report 50109 VacationDecision
{
    DefaultLayout = RDLC;
    RDLCLayout = './VacatonDecision.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    EnableExternalAssemblies = true;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; Employee)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(Year1; Year1)
            {
            }
            column(BrojDokumenta; BrojDokumenta)
            {
            }
            column(DatumRjesenja; DatumRjesenjaT)
            {
            }
            column(Company_logo; CompanyInformation.Picture)
            {
            }
            dataitem(DataItem5; "Vacation Grounds2")
            {
                RequestFilterFields = "Employee No.";
                column(WorkEXpDays; "Days based on Work experience")
                {

                }
                column(YearofVac; "Year")
                {

                }
                column(Disability; "Days based on Disability")
                {
                }
                column(Millitary; Millitary)
                {

                }
                column(MotherWithMoreCH; MotherWithMoreCH)
                {

                }
                column(SingleParent; SingleParent)
                {

                }
                column(SpecialCircumstances; SpecialCircumstances)
                {

                }
                column(Total_days; "Total days")
                {

                }
                column(Legal_Grounds; "Legal Grounds")
                {

                }
                column(StartFirstpart; "Starting Date of I part")
                {
                }
                column(EndFirstpart; "Ending Date of I part")
                {
                }
                column(Start2part; "Starting Date of II part")
                {
                }
                column(End2part; "Ending Date of II part")
                {
                }
                column(Position; Position)
                {
                }
                column(Sector; Sector)
                {

                }
                column(BrojDanaPrviDio; BrojDanaPrviDio)
                {

                }
                column(DanJavljanjanaposao; DanJavljanjanaposao)
                {

                }
                column(DrugiDioDana; DrugiDioDana)
                {

                }
                column(RanijeIskoristeniDani; RanijeIskoristeniDani)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields(Position, Sector);
                    DanJavljanjanaposao := "Ending Date of I part" + 1;
                    DrugiDioDana := "Total days" - BrojDanaPrviDio;
                end;


                trigger OnPreDataItem()
                begin
                    DatumRjesenjaT := FORMAT(DatumRjesenja, 0, '<Day,2>.<Month,2>.<Year4>.');
                    Year1 := FORMAT(DatumRjesenja, 0, '<Year4>.');


                end;





            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BrojDokumenta; BrojDokumenta)
                {
                    Caption = 'Broj dokumenta';
                }
                field(DatumRjesenja; DatumRjesenja)
                {
                    Caption = 'Datum rješenja';
                }
                field(BrojDanaPrviDio; BrojDanaPrviDio)
                {
                    Caption = 'Broj dana prvog dijela';
                }
                field(RanijeIskoristeniDani; RanijeIskoristeniDani)
                {
                    Caption = 'Ranije iskorišteni dani odmora';
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


    var

        Year1: Text;
        DatumRjesenja: Date;
        DatumRjesenjaT: Text;
        BrojDokumenta: Text;
        BrojDanaPrviDio: Integer;
        DanJavljanjanaposao: Date;
        DrugiDioDana: Integer;
        RanijeIskoristeniDani: Integer;
        CompanyInformation: Record "Company Information";

}
