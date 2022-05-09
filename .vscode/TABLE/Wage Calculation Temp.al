table 50021 "Wage Calculation Temp"
{
    // //

    Caption = 'Wage Calculation Temp';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
        }
        field(10; "Document Year"; Integer)
        {
            Caption = 'Document Year';
        }
        field(20; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(30; "Month Of Calculation"; Integer)
        {
            Caption = 'Month of Calculation';
        }
        field(31; "Year Of Calculation"; Integer)
        {
            Caption = 'Year Of Calculation';
        }
        field(35; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(40; "Month Of Wage"; Integer)
        {
            Caption = 'Month of Wage';
        }
        field(45; "Year Of Wage"; Integer)
        {
            Caption = 'Year of Wage';
        }
        field(50; "Employee Coefficient"; Decimal)
        {
            Caption = 'Employee Coefficient';
        }
        field(55; "Work Experience Percentage"; Decimal)
        {
            Caption = 'Work Experience Percentage';
        }
        field(60; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(64; "Base Tax Deduction"; Decimal)
        {
            Caption = 'Base Tax Deduction';
        }
        field(65; "Tax Deductions"; Decimal)
        {
            Caption = 'Tax Deductions';
        }
        field(70; "Work Experience Brutto"; Decimal)
        {
            Caption = 'Work Experience Brutto';
        }
        field(75; Brutto; Decimal)
        {
            Caption = 'Brutto';
        }
        field(80; "Contribution From Brutto"; Decimal)
        {
            Caption = 'Contribution From Brutto';
        }
        field(85; "Contribution Over Brutto"; Decimal)
        {
            Caption = 'Contribution Over Brutto';
        }
        field(90; "Net Wage"; Decimal)
        {
            Caption = 'Net Wage';
        }
        field(95; "Untaxable Wage"; Decimal)
        {
            Caption = 'Untaxable Wage';
        }
        field(100; "Tax Basis"; Decimal)
        {
            Caption = 'Tax Basis';
        }
        field(105; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(106; "Wage Addition Brutto"; Decimal)
        {
        }
        field(107; "Wage Addition Netto"; Decimal)
        {
        }
        field(110; "Contribution Per City"; Decimal)
        {
            Caption = 'Contribution Per City';
        }
        field(115; "Final Net Wage"; Decimal)
        {
            Caption = 'Final Net Wage';
        }
        field(120; "Wage Reduction"; Decimal)
        {
            Caption = 'Wage Reduction';
        }
        field(121; Transport; Decimal)
        {
            Caption = 'Transport';
        }
        field(125; Payment; Decimal)
        {
            Caption = 'Payment';
        }
        field(130; "Sick Leave-Company"; Decimal)
        {
            Caption = 'Sick Leave Company';
        }
        field(131; "Sick Leave-Fund"; Decimal)
        {
            Caption = 'Sick Leave-Fund';
        }
        field(135; "Contribution Category Code"; Code[10])
        {
            Caption = 'Contribution Category Code';
        }
        field(140; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(145; VAT; Decimal)
        {
            Caption = 'VAT';
        }
        field(150; Vacation; Decimal)
        {
            Caption = 'Vacation';
        }
        field(155; Holidays; Decimal)
        {
            Caption = 'Holidays';
        }
        field(160; "Wage Type"; Code[10])
        {
            Caption = 'Wage Type';
        }
        field(165; "Life Premium"; Decimal)
        {
            Caption = 'Life Insurance Premium';
        }
        field(166; "Heath Premium"; Decimal)
        {
            Caption = 'Add. Health Ins. Premium';
        }
        field(167; "Pension Premium"; Decimal)
        {
            Caption = 'Add. Pension Premium';
        }
        field(168; "Insurance Premium"; Decimal)
        {
            Caption = 'Total Ins. Premium';
        }
        field(171; "Wage (Base)"; Decimal)
        {
            Caption = 'Wage (Base)';
            Description = 'Osnovni neto iznos (Neto plata)';
        }
        field(172; "Net Wage (Calculated Base)"; Decimal)
        {
            Caption = 'Net Wage (Calculated Base)';
            Description = 'Osnovica neto iznos (obracunato)';
        }
        field(173; "Work Experience (Base)"; Decimal)
        {
            Caption = 'Work Experience (Base)';
            Description = 'Osnovica za minuli rad';
        }
        field(174; "Wage (Base) is Neto"; Boolean)
        {
            Caption = 'Wage (Base) is Neto';
            Description = 'Da li je polazna osnovica u brutto ili netto';
        }
        field(175; "Indirect Wage Addition Amount"; Decimal)
        {
            Caption = 'Indirect Wage Addition Amount';
        }
        field(176; "Net Wage After Tax"; Decimal)
        {
            Caption = 'Net Wage After Tax';
        }
        field(177; "Earnings Deduction"; Decimal)
        {
            Caption = 'Earnings Deduction';
        }
        field(178; "Minimal Netto Wage Difference"; Decimal)
        {
            Caption = 'Minimal Netto Wage Difference';
        }
        field(179; "Minimal Netto Wage"; Boolean)
        {
            Caption = 'Minimal Netto Wage';
        }
        field(180; "Meal to pay"; Decimal)
        {
            Caption = 'Meal to pay';
        }
        field(181; "Meal to refund"; Decimal)
        {
            Caption = 'Meal to refund';
        }
        field(182; "Wage Addition"; Decimal)
        {
            Caption = 'Wage Addition';
        }
        field(183; SGC; Code[10])
        {
            Caption = 'SGC';
        }
        field(184; "Experience Total"; Decimal)
        {
            Caption = 'Experience Total';
        }
        field(185; "Sick Fund Total"; Decimal)
        {
            Caption = 'Sick Fund Total';
        }
        field(186; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Worker, Board, Supervisor, Trainee';
            OptionMembers = Worker,Board,Supervisor,Trainee;
        }
        field(187; SubLinesHidden; Boolean)
        {
        }
        field(188; HiddenLine; Boolean)
        {
        }
        field(189; MasterLine; Boolean)
        {
        }
        field(190; "Hour Pool"; Decimal)
        {
            Caption = 'Hour Pool';
        }
        field(191; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            Description = 'Taken from Employee';
        }
        field(192; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            Description = 'Taken from Employee';
        }
        field(193; "General Coefficient"; Decimal)
        {
            Caption = 'General Coefficient';
        }
        field(194; "Contribution Over Netto"; Decimal)
        {
            Caption = 'Contribution Over Netto';
        }
        field(195; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
        }
        field(196; "Net Wage Netto 2"; Decimal)
        {
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(199; "Approved Expenditures"; Decimal)
        {
            Caption = 'Approved Expenditures';
        }
        field(201; "Unpaid Absence"; Decimal)
        {
            Caption = 'Unpaid Absence';
        }
        field(202; "Coeff. Difference"; Decimal)
        {
            Caption = 'Coeff. Difference';
        }
        field(203; "Unpaid Absence Hours"; Decimal)
        {
            Caption = 'Unpaid Absence Hours';
        }
        field(206; "Taxable Meal"; Decimal)
        {
        }
        field(207; "Brutto Meal"; Decimal)
        {
        }
        field(208; "Taxable Transport"; Decimal)
        {
        }
        field(209; "Brutto Transport"; Decimal)
        {
        }
        field(210; "Reported Amount From Brutto"; Decimal)
        {
        }
        field(211; "Individual Hour Pool"; Decimal)
        {
            Caption = 'Individual Hour Pool';
        }
        field(212; Use; Decimal)
        {
        }
        field(213; "Tax Basis (RS)"; Decimal)
        {
            Caption = 'Tax Basis (RS)';
        }
        field(214; "Tax (RS)"; Decimal)
        {
            Caption = 'Tax (RS)';
        }
        field(215; "Department Municipality"; Code[10])
        {
            Caption = 'Department Municipality';
        }
        field(216; "Municipality CIPS"; Code[10])
        {
            Caption = 'Municipality CIPS';
        }
        field(217; "Use Netto"; Decimal)
        {



            FieldClass = FlowField;


            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE("Use" = FILTER(true), "Employee No." = FIELD("Employee No."), "Wage Header No." = FIELD("Wage Header No."), "Wage Calculation Entry No." = FIELD("No.")));







        }
        field(218; Invalid; Boolean)
        {
        }
        field(219; "Regres Brutto"; Decimal)
        {
        }
        field(220; "Regres Netto"; Decimal)
        {
        }
        field(221; "Payment Date (TS Residents)"; Date)
        {
            Caption = 'Payment Date (TS Residents)';
        }
        field(222; "Payment Date (TS No Residents)"; Date)
        {
            Caption = 'Payment Date (TS No Residents)';
        }
        field(223; "Payment Date (Author Contract)"; Date)
        {
            Caption = 'Payment Date (Author Contract)';
        }
        field(224; Status; enum "Employee Status")
        {
            Caption = 'Status';

        }
        field(225; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(226; "Regres Brutto Separate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount Brutto" WHERE //(Regres=FILTER(true),
                                                                                ("Employee No." = FIELD("Employee No."),
                                                                               "Wage Header No." = FIELD("Wage Header No."),
                                                                                "Wage Calculation Entry No." = FIELD("No.")
                                                                               ));// Calculated=CONST(Yes)));
            Caption = 'Regres Brutto';

        }


        field(227; "Regres Netto Separate"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Regres = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                                         "Wage Calculation Entry No." = FIELD("No."),
                                                                         Calculated = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(228; "Regres Netto Tax Separate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Regres = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                                        "Wage Calculation Entry No." = FIELD("No."),
                                                                         Calculated = FILTER(true)));
            Caption = 'Regres Netto';
            //FieldClass = FlowField;
        }
        field(229; "Regres Netto Tax"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Regres = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                        "Wage Header No." = FIELD("Wage Header No."),
                                                                         "Wage Calculation Entry No." = FIELD("No.")));
            Caption = 'Regres Netto';

        }
        field(230; "Tax Base Additions"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Regres = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                                         "Wage Calculation Entry No." = FIELD("No."),
                                                                         Taxable = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(231; "Tax Additions"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE(Regres = FILTER(true),
                                                         "Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Calculation Entry No." = FIELD("No."),
                                                         Taxable = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(232; "Employee Name"; Text[250])
        {
        }
        field(233; "Regres Netto With Wage"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                    "Wage Calculation Entry No." = FIELD("No."),
                                                                     Locked = FILTER(true),
                                                                     Calculated = FILTER(false)));
            Caption = 'Regres Netto';

        }
        field(234; "SAP 1"; Code[10])
        {
        }
        field(235; "SAP 2"; Code[10])
        {
        }
        field(236; "Date Of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
        }
        field(237; "Meal Correction"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                                     "Year of Wage" = FIELD("Year Of Wage"),
                                                                    "Wage Addition Type" = FILTER('TOPLI OBR')));

        }
        field(238; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(239; ZZO; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Brutto WHERE("Employee No." = FIELD("Employee No."),
                                                            "Wage Header No." = FIELD("Wage Header No."),
                                                            "Wage Addition Type" = FILTER('KOREKCIJE')));
            FieldClass = FlowField;
        }
        field(240; "ZZO Dopr"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  "Wage Addition Type" = FILTER('KOREKCIJE')));

        }
        field(50295; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(50299; "B-1"; Code[10])
        {
            Caption = 'B-1';
            Editable = false;
        }
        field(50300; "B-1 Description"; Text[250])
        {
            Caption = 'B-1 Description';
            Editable = false;
        }
        field(50301; "B-1 (with regions)"; Code[10])
        {
            Caption = 'B-1 (with regions)';
            Editable = false;
        }
        field(50302; "B-1 (with regions) Description"; Text[250])
        {
            Caption = 'B-1 (with regions) Description';
            Editable = false;
        }
        field(50303; Stream; Code[10])
        {
            Caption = 'Stream';
            Editable = false;
        }
        field(50304; "Stream Description"; Text[250])
        {
            Caption = 'Stream Description';
            Editable = false;
        }
        field(50316; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(50317; "Position Code"; Code[20])
        {
            Caption = 'Position Code';

            trigger OnValidate()
            begin
                /*CALCFIELDS("Position Description","Minimal Education Level");
                
                   position.SETFILTER(Code,"Position Code");
                   IF position.FINDFIRST THEN BEGIN
                     "Position Benef".SETFILTER("Position Code","Position Code");
                     IF "Position Benef".FINDFIRST THEN BEGIN
                       REPEAT
                     MAI.INIT;
                     MAI."Employee No.":="Employee No.";
                     MAI."Position Code":="Position Code";
                     MAI."Misc. Article Code":="Position Benef".Code;
                     MAI.Description:="Position Benef".Description;
                     MAI.Amount:="Position Benef".Amount;
                     MAI."Emp. Contract Ledg. Entry No.":=Rec."No.";
                     MAI."From Date":="Starting Date";
                     MAI.INSERT;
                     UNTIL "Position Benef".NEXT=0;
                     END
                END;
                position.SETFILTER("Org. Structure",'%1', "Org. Structure");
                position.SETFILTER(Code,'%1',"Position Code");
                position.SETFILTER("Position ID",'%1',"Position ID");
                IF position.FINDFIRST THEN
                  BEGIN
                    position."Employee No.":="Employee No.";
                    position."Employee Full Name":= "Employee Name";
                    position.MODIFY;
                  END;*/

            end;
        }
        field(50318; "Position ID"; Code[10])
        {
            Caption = 'Position ID';
        }
        field(50319; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            Editable = false;
        }
        field(50320; "Management Level"; Code[10])
        {
            Caption = 'Management Level';
        }
        field(50321; Incentive; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     //  Calculated=CONST(Yes),
                                                                     "Wage Addition Type" = FILTER('INC*')));

        }
        field(50322; "Phisical Org Dio"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Code WHERE(Code = FIELD("Phisical Department Code")));
            Caption = 'Org. Part';
            // FieldClass = FlowField;
            TableRelation = Department.Code;
        }
        field(50323; "Org Dio"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Code WHERE(Code = FIELD("Department Code")));
            Caption = 'Org. Part';

        }
        field(50328; "Phisical Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Department.Code;
        }
        field(50329; "Incentive SFE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC SFE')));

        }
        field(50330; "Incentive PRAVNA"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                    "Wage Addition Type" = FILTER('INC PRAV')));

        }
        field(50331; "Incentive FIZ"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                    "Wage Addition Type" = FILTER('INC FIZ')));

        }
        field(50332; "Incentive CORP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC CORP')));

        }
        field(50333; "Incentive SME"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC SME')));

        }
        field(50334; "Incentive MICRO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC MICRO')));

        }
        field(50335; "Tax Incentive"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Addition Type" = FILTER('INC*')));
            Caption = 'Tax Incentive';

        }
        field(50336; "Contribution From Incentive"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  "Wage Addition Type" = FILTER('INC*')));
            Caption = 'Contribution From Incentive';

        }
        field(50337; "Contribution Over Incentive"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                               "Wage Addition Type" = FILTER('INC*')));
            Caption = 'Contribution Over Incentive';
            FieldClass = FlowField;
        }
        field(50338; "Leaving Payment Retirement"; Decimal)
        {
            FieldClass = Flowfield;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Leaving Payment Retirement';

        }
        field(50339; "Tax Leaving Payment Retirement"; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Tax Leaving Payment Retirement';
            FieldClass = FlowField;
        }
        field(50340; "Contribution From LPR"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                 "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Contribution From LPR';
            FieldClass = FlowField;
        }
        field(50341; "Contribution Over LPR"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                               "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Contribution Over LPR';
            FieldClass = FlowField;
        }
        field(50342; "Leaving Payment"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                    "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Leaving Payment';
            FieldClass = FlowField;
        }
        field(50343; "Tax Leaving Payment"; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                        "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Tax Leaving Payment';
            FieldClass = FlowField;
        }
        field(50344; "Contribution From LP"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                 "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Contribution From LP';
            FieldClass = FlowField;
        }
        field(50345; "Contribution Over LP"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                               "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Contribution Over LP';
            FieldClass = FlowField;
        }
        field(50354; "Total Netto by Contract"; Decimal)
        {
            Caption = 'Total Netto';
        }
        field(50355; "Netto by Contract"; Decimal)
        {
            Caption = ' Netto by Contract';
        }
        field(50356; "Regres Netto With Wage Taxable"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(true),
                                                                     Calculated = FILTER(false),
                                                                     Taxable = FILTER(true)));
            Caption = 'Regres Netto';
            FieldClass = FlowField;
        }
        field(50357; "Regres Netto With Wage UnTax"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(true),
                                                                     Calculated = FILTER(false),
                                                                     Taxable = FILTER(false)));
            Caption = 'Regres Netto';
            FieldClass = FlowField;
        }
        field(50358; "Regres Netto Separate UnTax"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                    "Wage Calculation Entry No." = FIELD("No."),
                                                                     Calculated = FILTER(true),
                                                                     Taxable = FILTER(false)));
            Caption = 'Regres Netto';
            FieldClass = FlowField;
        }
        field(50359; "Regres Netto Separate Tax"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                    "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                    "Wage Calculation Entry No." = FIELD("No."),
                                                                     Calculated = FILTER(true),
                                                                     Taxable = FILTER(true)));
            Caption = 'Regres Netto';
            FieldClass = FlowField;
        }
        field(50360; "Education Level"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Wage Header No.", "Wage Calculation Type", "Employee No.")
        {
        }
        key(Key2; "Wage Header No.", "Entry No.")
        {
            SumIndexFields = Brutto, "Contribution From Brutto", "Contribution Over Brutto", "Net Wage", Tax, "Contribution Per City", "Final Net Wage", "Wage Reduction", Transport, Payment, "Sick Leave-Company", "Sick Leave-Fund", "Tax Basis", "Work Experience (Base)", "Wage (Base)", "Untaxable Wage";
        }
        key(Key3; "Month Of Calculation")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ATaxTemp: Record "Contribution Per Employee";
        RedTemp: Record "Reduction per Wage Temp";
        TaxEmpTemp: Record "Tax Per Employee Temp";

    procedure SetMasters("WHNo.": Code[20]; "EntryNo.": Integer)
    var
        LastENo: Code[20];
        WC: Record "Wage Calculation Temp";
    begin
        WC.SETCURRENTKEY("Wage Header No.", "Entry No.");
        WC.SETRANGE("Wage Header No.", "WHNo.");
        WC.SETRANGE("Entry No.", "EntryNo.");

        IF WC.FIND('-') THEN BEGIN
            WC.MODIFYALL(MasterLine, FALSE);
            WC.MODIFYALL(MasterLine, TRUE);
            WC.MODIFYALL(HiddenLine, TRUE);
            LastENo := '';
            IF WC.FIND('-') THEN
                REPEAT
                    IF WC."Employee No." <> LastENo THEN BEGIN
                        WC.MasterLine := TRUE;
                        WC.HiddenLine := TRUE;
                        WC.MasterLine := FALSE;
                        WC.MODIFY;
                    END;
                    LastENo := WC."Employee No.";
                UNTIL WC.NEXT = 0;

        END;
    end;

    procedure ExpandRows("WHNo.": Code[20]; "EntryNo.": Integer)
    var
        LastENo: Code[20];
        WC: Record "Wage Calculation Temp";
        WC2: Record "Wage Calculation Temp";
    begin
        WC.SETCURRENTKEY("Wage Header No.", "Entry No.");
        WC.SETRANGE("Wage Header No.", "WHNo.");
        WC.SETRANGE("Entry No.", "EntryNo.");

        WC2.SETCURRENTKEY("Wage Header No.", "Entry No.");
        WC2.SETRANGE("Wage Header No.", "WHNo.");
        WC2.SETRANGE("Entry No.", "EntryNo.");
        WC2.SETRANGE(MasterLine, FALSE);

        IF WC.FIND('-') THEN BEGIN
            WC.SETRANGE(MasterLine, TRUE);
            IF WC.FIND('-') THEN
                REPEAT
                    WC2.SETRANGE("Employee No.", WC."Employee No.");
                    IF WC2.FIND('-') THEN BEGIN
                        WC.HiddenLine := FALSE;
                        WC.MODIFY;
                    END;
                UNTIL WC.NEXT = 0;

            WC.SETRANGE(MasterLine, FALSE);
            WC.MODIFYALL(MasterLine, FALSE);
        END;
    end;

    procedure MergeRows("WHNo.": Code[20]; "EntryNo.": Integer)
    var
        LastENo: Code[20];
        WC: Record "Wage Calculation Temp";
    begin
        WC.SETCURRENTKEY("Wage Header No.", "Entry No.");
        WC.SETRANGE("Wage Header No.", "WHNo.");
        WC.SETRANGE("Entry No.", "EntryNo.");
        IF WC.FIND('-') THEN BEGIN
            WC.SETRANGE(MasterLine, TRUE);
            WC.MODIFYALL(HiddenLine, TRUE);

            WC.SETRANGE(MasterLine, FALSE);
            WC.MODIFYALL(MasterLine, TRUE);
        END;
    end;
}

