report 50050 "OLP-1021"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OLP-1021.rdl';

    dataset
    {
        dataitem(DataItem30; "Employee")
        {
            RequestFilterFields = "No.";
            column(EmpNo; DataItem30."No.")
            {
            }
            column(EmpFirstName; DataItem30."First Name")
            {
            }
            column(EmpLastName; DataItem30."Last Name")
            {
            }
            column(EmpAddress; DataItem30."Address CIPS")
            {
            }
            column(EmpCity; DataItem30."City CIPS")
            {
            }
            column(EmpPostCode; DataItem30."Post Code CIPS")
            {
            }
            column(EmpID; DataItem30."Employee ID")
            {
            }
            column(Year; Year)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompInfo.Address)
            {
            }
            column(CompanyRegistrationNo; CompInfo."Registration No.")
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPostCode; CompInfo."Post Code")
            {
            }
            dataitem(DataItem1; "Wage Calculation")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Payment Date")
                                    ORDER(Ascending);
                column(RedBroj; RedBroj)
                {
                }
                column(PrihodKM; Brutto + BruttoAdd)
                {
                }
                column(DatumIsplate; "Payment Date")
                {
                }
                column(PIO; sumPIO)
                {
                }
                column(Zdrav; sumZDR)
                {
                }
                column(Nezap; sumNZ)
                {
                }
                column(PorezOdb; "Tax Deductions")
                {
                }
                column(UkupneStopeDopr; "Contribution From Brutto")
                {
                }
                column(TaxBasis; "Tax Basis" + TaxBasisAdd)
                {
                }
                column(Tax; Tax + TaxAdd)
                {
                }
                column(StopeDopr; StopeDopr)
                {
                }
                column(Use; Use)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;
                    RedBroj += 1;
                    CALCFIELDS("Use Netto");
                    t_ContrEmp.RESET;
                    CLEAR(t_ContrEmp);
                    t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1', 'D-PIO-IZ');
                    t_ContrEmp.SETFILTER(t_ContrEmp."Amount From Wage", '>%1', 0);
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumPIO += t_ContrEmp."Amount From Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;
                    t_ContrEmp1.RESET;
                    CLEAR(t_ContrEmp1);

                    t_ContrEmp1.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp1.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp1.SETFILTER(t_ContrEmp1."Contribution Code", '%1', 'D-ZDRAV-IZ');
                    t_ContrEmp1.SETFILTER(t_ContrEmp1."Amount From Wage", '>%1', 0);
                    IF t_ContrEmp1.FINDFIRST THEN BEGIN
                        REPEAT
                            sumZDR += t_ContrEmp1."Amount From Wage";
                        UNTIL t_ContrEmp1.NEXT = 0;
                    END;
                    t_ContrEmp2.RESET;
                    CLEAR(t_ContrEmp2);

                    t_ContrEmp2.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp2.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Contribution Code", '%1', 'D-NEZAP-IZ');
                    t_ContrEmp2.SETFILTER(t_ContrEmp2."Amount From Wage", '>%1', 0);

                    IF t_ContrEmp2.FINDFIRST THEN BEGIN
                        REPEAT
                            sumNZ += t_ContrEmp2."Amount From Wage";
                        UNTIL t_ContrEmp2.NEXT = 0;
                    END;
                    StopeDopr := 0;
                    ContrCatCon.SETRANGE("Category Code", DataItem1."Contribution Category Code");
                    ContrCatCon.SETRANGE("Contribution Code", 'D-PIO-IZ');
                    IF ContrCatCon.FIND('-') THEN
                        StopeDopr += ContrCatCon.Percentage;
                    ContrCatCon.SETRANGE("Contribution Code", 'D-ZDRAV-IZ');
                    IF ContrCatCon.FIND('-') THEN
                        StopeDopr += ContrCatCon.Percentage;
                    ContrCatCon.SETRANGE("Contribution Code", 'D-NEZAP-IZ');
                    IF ContrCatCon.FIND('-') THEN
                        StopeDopr += ContrCatCon.Percentage;


                    BruttoAdd := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;
                    //*******************************************Additions****************************************//
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            BruttoAdd += WVE."Cost Amount (Brutto)";
                            NettoAdd += WVE."Cost Amount (Netto)";
                        UNTIL WVE.NEXT = 0;

                    WVET.SETFILTER("Document No.", "Wage Header No.");
                    WVET.SETFILTER("Employee No.", "Employee No.");
                    WVET.SETFILTER("Wage Calculation Type", '%1', 4);
                    WVET.SETFILTER("Entry Type", '%1', WVET."Entry Type"::Tax);
                    IF WVET.FIND('-') THEN
                        REPEAT
                            TaxAdd := TaxAdd + WVET."Cost Amount (Netto)";
                            TaxBasisAdd += (WVET."Cost Amount (Netto)" / 0.1);
                        UNTIL WVET.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    CompInfo.GET;

                    DataItem1.SETRANGE("Payment Date", StartDated, EndDated);
                    RedBroj := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                EVALUATE(Godina, FORMAT(Year));
                StartDate := '1.1.' + Godina;
                EndDate := '31.12.' + Godina;
                EVALUATE(StartDated, StartDate);
                EVALUATE(EndDated, EndDate);
                SETFILTER("Wage Posting Group", '%1', 'FBiH');
                //SETFILTER(Status,'%1',Status::Active);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Year';
                    field(Year; Year)
                    {
                        Caption = 'Year';
                    }
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
        Year := DATE2DMY(CALCDATE('-2M', WORKDATE), 3);
    end;

    var
        Year: Integer;
        ContrCatCon: Record "Contribution Category Conn.";
        CompInfo: Record "Company Information";
        EmpID: Code[20];
        EmpAddress: Text[50];
        EmpFirstName: Text[50];
        EmpLastName: Text[50];
        sumZDR: Decimal;
        sumPIO: Decimal;
        sumNZ: Decimal;
        t_ContrEmp: Record "Contribution Per Employee";
        t_ContrEmp1: Record "Contribution Per Employee";
        t_ContrEmp2: Record "Contribution Per Employee";
        Godina: Text;
        StartDate: Text;
        EndDate: Text;
        StartDated: Date;
        EndDated: Date;
        RedBroj: Integer;
        StopeDopr: Decimal;
        TaxBasisAdd: Decimal;
        TaxAdd: Decimal;
        BruttoAdd: Decimal;
        NettoAdd: Decimal;
        WVE: Record "Wage Value Entry";
        WVET: Record "Wage Value Entry";
        WVEC: Record "Wage Value Entry";
}

