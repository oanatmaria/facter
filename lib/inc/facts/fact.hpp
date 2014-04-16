#ifndef LIB_INC_FACTS_FACT_HPP_
#define LIB_INC_FACTS_FACT_HPP_

namespace cfacter { namespace facts {

    /**
     * Stores the constant fact names.
     */
    struct fact
    {
        constexpr static char const* kernel = "kernel";
        constexpr static char const* kernel_version = "kernelversion";
        constexpr static char const* kernel_release = "kernelrelease";
        constexpr static char const* kernel_major_release = "kernelmajrelease";
        constexpr static char const* operating_system = "operatingsystem";
        constexpr static char const* os_family = "osfamily";
        constexpr static char const* operating_system_release = "operatingsystemrelease";
        constexpr static char const* operating_system_major_release = "operatingsystemmajrelease";
        constexpr static char const* hostname = "hostname";
        constexpr static char const* lsb_dist_id = "lsbdistid";
        constexpr static char const* lsb_dist_release = "lsbdistrelease";
        constexpr static char const* lsb_dist_codename = "lsbdistcodename";
        constexpr static char const* lsb_dist_description = "lsbdistdescription";
        constexpr static char const* lsb_dist_major_release = "lsbmajdistrelease";
        constexpr static char const* lsb_dist_minor_release = "lsbminordistrelease";
        constexpr static char const* lsb_release = "lsbrelease";
    };

}}  // namespace cfacter::facts

#endif  // LIB_INC_FACTS_FACT_HPP_
