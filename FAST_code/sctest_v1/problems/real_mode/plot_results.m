function plot_results()

addpath('../..');
set_paths();



%Get default plot settings
settings = default_settings();

clf
hold off
figure(1)

signals = 1:4;
plot_coeff_main(settings,signals);
%plot_wnd_len_main(settings,signals)
%plot_block(settings,signals);

end





function plot_block(settings,signals)
    field.name = ['Number of spectral peaks per block '  ...
                 ];
    field.tl = @(snr) ['Signal to Noise: ' num2str(snr)];
    field.id   = 'spec_block_num_coeff';
    field.param_type = 'setting';
    field.path = 'data';
    field.data = 'block_num_coeff';
    field.method = 1;

    run(settings,signals,field);
end


function plot_coeff_main(settings,signals)
    data = 'num_coeff_wnd64_';
    ct = @(name) [ data '_' name ];
    plot_coeff(ct('signal'),1,settings,signals);
    plot_coeff(ct('noise'),2,settings,signals);
    plot_coeff(ct('no_signal'),3,settings,signals);

end

function plot_wnd_len_main(settings,signals)
    plot_wnd_len('wnd_len_signal',1,settings,signals);
    plot_wnd_len('wnd_len_noise',2,settings,signals);
    plot_wnd_len('wnd_len_no_signal',3,settings,signals);
end

function plot_coeff(data,id,settings,signals)
    field.name = 'Number of spectral peaks kept';
    field.id   = 'peak_num_coeff';
    field.param_type = 'setting';
    field.tl = @(snr) ['Signal to Noise: ' num2str(snr)];
    field.path = 'data';
    field.data = data;
    field.method = 1;
    field.group_id = id;

    run(settings,signals,field);
end

function plot_wnd_len(data,id,settings,signals)
    field.name = 'Spectral window length';
    field.id   = 'spec_wnd_len';
    field.param_type = 'setting';
    field.tl = @(snr) ['Signal to Noise: ' num2str(snr)];
    field.path = 'data';
    field.data = data;
    field.method = 1;
    field.group_id = id;

    run(settings,signals,field);
end 
 

function plot_spec_high_f(test_suite,data,stats,method,group_id,plt)
    field.name = 'Number of spectral frequencies';
    field.id   = 'spec_high_f';
    field.param_type = 'setting';
    plot_variance(test_suite,data,stats,field,method,group_id,plt);
end  
function run(settings,signals,field)
    for i=signals
        [test_suite,data,stats] = load_data(field,i);
        field.title = field.tl(test_suite{1}.snr);
        plot_variance(test_suite,data,stats,field,field.method,field.group_id,settings.plt);
    end
    %save2pdf([settings.plt.path '/' param '_' test_suite{1}.method{method}]);
end

function [test_suite,data,stats] = load_data(save_settings,id)
    load([save_settings.path '/' save_settings.data num2str(id)],'test_suite','stats','data');
end 
